{pkgs, ...}: let
  jdkVersions = {
    jdk8 = pkgs.jdk8;
    jdk17 = pkgs.jdk17;
    jdk21 = pkgs.jdk21;
  };
  mainJdk = jdkVersions.jdk21; # will be added to $PATH

  cacertsDir = builtins.path {
    path = ../../../certs;
    name = "custom-cacerts";
  };

  makeCustomTruststore = jdk: pkgs.stdenv.mkDerivation {
    name = "custom-truststore-${jdk.version}";
    buildInputs = [jdk];
    buildCommand = let
      cacerts =
        if pkgs.stdenv.isDarwin
        then "${jdk}/lib/security/cacerts"
        else "${jdk}/lib/openjdk/lib/security/cacerts";
    in ''
      mkdir -p $out

      [ ! -f "${cacerts}" ] && exit 0
      cp ${cacerts} $out/cacerts
      chmod +w $out/cacerts

      for cert in ${cacertsDir}/*; do
        if [ -f "$cert" ]; then
          $buildInputs/bin/keytool -importcert \
            -keystore $out/cacerts \
            -storetype PKCS12 \
            -storepass changeit \
            -keypass changeit \
            -noprompt \
            -alias "custom-$(basename "$cert" | sed 's/\..*$//')" \
            -file "$cert"
        fi
      done
    '';
  };
  
  jdkHomeFiles = builtins.listToAttrs (
    map (name: {
      name = ".${name}";
      value.source = jdkVersions.${name}.home;
    }) (builtins.attrNames jdkVersions)
  );
  
  truststoreFiles = builtins.listToAttrs (
    map (name: {
      name = ".java-truststores/${name}-cacerts";
      value.source = "${makeCustomTruststore jdkVersions.${name}}/cacerts";
    }) (builtins.attrNames jdkVersions)
  );
in {
  imports = [./java-props.nix];

  javaProps = {
    enable = true;
    system = {
      "javax.net.ssl.trustStore" = "${makeCustomTruststore mainJdk}/cacerts";
      "javax.net.ssl.trustStorePassword" = "changeit";
    };
  };

  programs.java = {
    enable = true;
    package = mainJdk;
  };

  home.file = {
    ".jdk".source = "${mainJdk.home}";
  } // jdkHomeFiles // truststoreFiles;
}

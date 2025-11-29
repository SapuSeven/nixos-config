{pkgs, ...}: let
  jdk = pkgs.jdk21;
  cacertsDir = builtins.path {
    path = ../../../certs;
    name = "custom-cacerts";
  };

  customTruststore = pkgs.stdenv.mkDerivation {
    name = "custom-truststore";
    buildInputs = [jdk];
    buildCommand = let
      cacerts =
        if pkgs.stdenv.isDarwin
        then "${jdk}/lib/security/cacerts"
        else "${jdk}/lib/openjdk/lib/security/cacerts";
    in ''
      mkdir -p $out
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
in {
  imports = [./java-props.nix];

  javaProps = {
    enable = true;
    system = {
      "javax.net.ssl.trustStore" = "${customTruststore}/cacerts";
      "javax.net.ssl.trustStorePassword" = "changeit";
    };
  };

  programs.java = {
    enable = true;
    package = jdk;
  };
}

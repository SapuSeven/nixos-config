{ pkgs, ... }:
let
  cacertsDir = builtins.path {
    path = ../../../certs;
    name = "custom-cacerts";
  };

  customTruststore = pkgs.stdenv.mkDerivation {
    name = "custom-truststore";
    buildInputs = [ pkgs.jdk21 ];
    buildCommand = ''
      mkdir -p $out

      ${pkgs.p11-kit.bin}/bin/trust extract \
        --format=java-cacerts \
        --purpose=server-auth \
        $out/cacerts

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
  home.sessionVariables = {
    JAVAX_NET_SSL_TRUSTSTORE = "${customTruststore}/cacerts";
    JAVAX_NET_SSL_TRUSTSTORE_PASSWORD = "changeit";
    #_JAVA_OPTIONS = "-Djavax.net.ssl.trustStore=${customTruststore}/cacerts -Djavax.net.ssl.trustStorePassword=changeit";
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}

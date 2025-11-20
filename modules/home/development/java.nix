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
      # Copy the default cacerts as base
      cp ${pkgs.jdk21}/lib/openjdk/lib/security/cacerts $out/cacerts
      chmod +w $out/cacerts

      # Import your certificates
      for cert in ${cacertsDir}/*; do
        if [ -f "$cert" ]; then
          keytool -importcert \
            -keystore $out/cacerts \
            -storepass changeit \
            -noprompt \
            -alias "custom-$(basename "$cert" | sed 's/\..*$//')" \
            -file "$cert"
        fi
      done
    '';
  };
in {
  programs.zsh.sessionVariables = {
    JAVAX_NET_SSL_TRUSTSTORE = "${customTruststore}/cacerts";
    JAVAX_NET_SSL_TRUSTSTORE_PASSWORD = "changeit";
    _JAVA_OPTIONS = "-Djavax.net.ssl.trustStore=${customTruststore}/cacerts -Djavax.net.ssl.trustStorePassword=changeit";
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}

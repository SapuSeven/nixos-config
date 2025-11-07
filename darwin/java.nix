{ pkgs, lib, ... }:

let
  jdk = pkgs.temurin-bin-21;
in
{
  environment = {
    systemPackages = [ jdk ];

    variables = {
      JAVA_HOME = "${jdk}";
    };
  };
}


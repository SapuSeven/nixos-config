# A Nix module to set system-wide Java properties
{ config, lib, ... }:
with lib;

let
  toJvmFlags = props: lib.concatStringsSep " " (
    lib.mapAttrsToList (k: v: "-D${k}=${lib.escapeShellArg v}") props
  );

  toGradleProps = props: lib.concatStrings (
    lib.mapAttrsToList (k: v: "systemProp.${k}=${v}\n") props
  );
in
{
  options.javaProps = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to apply custom Java properties.";
    };
    system = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "Java system properties to set (e.g. javax.net.ssl.trustStore).";
    };
  };

  config = let
    props = config.javaProps.system;
  in mkIf config.javaProps.enable {
    home.sessionVariables._JAVA_OPTIONS = toJvmFlags props;
    home.file.".gradle/gradle.properties".text = toGradleProps props;
  };
}


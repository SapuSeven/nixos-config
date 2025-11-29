{
  config,
  lib,
  host,
  ...
}: let
  isImpermanent = host.impermanent or false;
  persistDir = "/nix/persist/home/${host.user}";
in {
  options.persistence = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf lib.types.str);
    description = "Custom persistence configuration for impermanent hosts.";
    default = {};
  };

  config = lib.optionalAttrs isImpermanent {
    home.persistence."${persistDir}".directories = config.persistence.directories;
  };
}

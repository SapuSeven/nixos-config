{
  config,
  lib,
  host,
  ...
}: let
  isImpermanent = host.impermanent or false;
  persistDir = "/nix/persist/system";
in {
  # Custom options for ease of use
  options.persistence = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf lib.types.str);
    description = "Custom persistence configuration for impermanent hosts.";
    default = {};
  };

  config = lib.optionalAttrs isImpermanent {
    environment.persistence."${persistDir}" = {
      # Default persistence options
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/backlight"
        "/etc/nixos"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ] ++ config.persistence.directories;
      files = [
        "/etc/machine-id"
        #{ file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
      ];
    };
  };
}

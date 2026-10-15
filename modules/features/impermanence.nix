{inputs, ...}: {
  flake-file.inputs = {
    impermanence.url = "github:nix-community/impermanence";
  };

  flake.modules.nixos.impermanence = {
    lib,
    config,
    ...
  }: let
    cfg = config.persistence;
  in {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    config = lib.mkIf cfg.enable {
      home-manager.sharedModules = [ inputs.self.modules.homeManager.impermanence ];

      environment.persistence."${cfg.persistDir}" = {
        hideMounts = true;
        # TODO: Remove those default values
        directories =
          [
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
          ]
          ++ cfg.directories;
        files =
          [
            "/etc/machine-id"
            #{ file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
          ]
          ++ cfg.files;
      };
    };
   
    options.persistence = {
      enable = lib.mkEnableOption "Enable persistence";

      persistDir = lib.mkOption {
        type = lib.types.str;
        description = "Path for persisted files";
        default = "/nix/persist";
      };

      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of files to persist";
        default = [];
      };

      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of directories to persist";
        default = [];
      };
    };
  };

  flake.modules.homeManager.impermanence = {lib, config, ...}:
  let
    cfg = config.persistence;
  in {
    config = lib.mkIf cfg.enable {
      home.persistence."${cfg.persistDir}" = {
        directories = cfg.directories;
        files = cfg.files;
      };
    };

    options.persistence = {
      enable = lib.mkEnableOption "Enable persistence";

      persistDir = lib.mkOption {
        type = lib.types.str;
        description = "Path for persisted files";
        default = "/nix/persist";
      };

      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of files to persist";
        default = [];
      };

      directories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of directories to persist";
        default = [];
      };
    };
  };
}

{ config, lib, pkgs, inputs, ... }:
let
  host = config.host;
  isImpermanent = host.impermanent or false;
  persistDir = "/nix/persist/home/${host.user}";
in
{
  options.persistence = {
    type = with lib.types; submodules {
      directories = {
        type = listOf str;
        default = [];
        description = "List of paths to persist across reboots.";
      };
    };
    description = "Custom persistence configuration for impermanent hosts.";
  };

  config = lib.mkIf isImpermanent {
    #imports = [ inputs.impermanence.homeManager ];

    home.persistence."${persistDir}".directories = config.persistence.directories;
  };
}

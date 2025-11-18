{ config, lib, pkgs, inputs, ... }:
let
  host = config.host;
  isImpermanent = host.impermanent or false;
  persistDir = "/nix/persist/home/${host.user}";
in
{
  options.persistence.directories = {
    type = with lib.types; listOf str;
    default = [];
    description = "List of paths to persist across reboots for impermanent hosts.";
  };

  config = lib.mkIf isImpermanent {
    #imports = [ inputs.impermanence.homeManager ];

    home.persistence."${persistDir}".directories = config.persistence.directories;
  };
}

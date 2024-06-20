{ inputs, outputs, host, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Home manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs host; };
    backupFileExtension = "backup";
    users.paul = {
      imports = [
        ../home-manager/paul.nix
        ../modules/home  # Include all modules
      ];
    };
    users.root = {
      imports = [
        ../home-manager/root.nix
        ../modules/home/git.nix  # include only Git module for doas nixos-rebuild to work properly
      ];
    };
  };
}

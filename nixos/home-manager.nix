{ inputs, outputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Home manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "backup";
    users.paul = {
      imports = [
        ../home-manager/home.nix
        ../modules/home
      ];
    };
  };
}

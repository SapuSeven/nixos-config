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
        ../home-manager/home.nix
        ../modules/home
      ];
    };
  };
}

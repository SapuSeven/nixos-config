{ inputs, outputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Home manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users.paul = {
      imports = [
        ../home-manager/home.nix
        ../modules/home
      ];
    };
  };
}

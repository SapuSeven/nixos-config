{
  inputs,
  ...
}:
{
  flake.modules.nixos.system-base =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (final: _prev: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final) config;
            system = pkgs.stdenv.hostPlatform.system;
          };
        })
      ];
      nixpkgs.config.allowUnfree = true;

      nix.settings = {
        substituters = [
          "https://cache.nixos.org?priority=10"
          "https://install.determinate.systems"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM"
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        download-buffer-size = 1024 * 1024 * 1024;

        trusted-users = [
          "root"
          "@wheel"
        ];
      };

      nix.extraOptions = ''
        warn-dirty = false
        keep-outputs = true
      '';

      system.stateVersion = "23.05";
    };

  flake.modules.homeManager.system-base = {config, pkgs, lib, ...}: {
    home.homeDirectory =
      if pkgs.stdenv.hostPlatform.isDarwin then
        (lib.mkForce "/Users/${config.home.username}")
      else
        "/home/${config.home.username}";
    home.stateVersion = "23.05";
  };
}

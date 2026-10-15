{
  inputs,
  lib,
  ...
}:
{
  # Helper functions for creating system / home-manager configurations

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.lib = {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos."host-${name}"
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            host.name = lib.mkDefault name;
          }
        ];
      };
    };

    mkDarwin = system: name: {
      ${name} = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          inputs.self.modules.darwin."host-${name}"
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            host.name = lib.mkDefault name;
          }
        ];
      };
    };

    mkHomeManager = system: name: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          inputs.self.modules.homeManager."${name}"
          { nixpkgs.config.allowUnfree = true; }
        ];
      };
    };
  };
}

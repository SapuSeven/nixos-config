{
  description = "Desktop nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # See the 'stable-packages' overlay at 'overlays/default.nix'.

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Secrets
    agenix.url = "github:ryantm/agenix";

    # Styling
    #catppuccin.url = "github:catppuccin/nix/c4dac42a4fadc49bbd939fb3531673dbb3b0a949"; # Last commit before gtk deprecation
    catppuccin.url = "github:catppuccin/nix";
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    catppuccin,
    impermanence,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          host = "desktop";
          inherit inputs outputs;
        };
        modules = [
          ./nixos/host-desktop.nix

          # Add other modules here
          impermanence.nixosModules.impermanence

          # TODO: How can this be put in a separate module?
          {
            # TODO: Don't hard-code system
            environment.systemPackages = [agenix.packages."x86_64-linux".default];
          }
          agenix.nixosModules.default
          {
            age.identityPaths = ["/home/paul/.ssh/id_ed25519"];
          }

          catppuccin.nixosModules.catppuccin
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          host = "laptop";
          inherit inputs outputs;
        };
        modules = [
          ./nixos/host-laptop.nix

          # Add other modules here
          impermanence.nixosModules.impermanence
          agenix.nixosModules.default
          catppuccin.nixosModules.catppuccin
        ];
      };
    };
  };
}

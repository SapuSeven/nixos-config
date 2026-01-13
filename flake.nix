{
  description = "Desktop nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # See the '(un)stable-packages' overlay at 'overlays/default.nix'.

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # nvim
    nvf.url = "github:NotAShelf/nvf/v0.8";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    # Secrets
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # declarative homebrew management (macOS)
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Lazy Apps
    lazy-apps.url = "github:SapuSeven/nix-lazy-apps";
    lazy-apps.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    # Styling
    #catppuccin.url = "github:catppuccin/nix/c4dac42a4fadc49bbd939fb3531673dbb3b0a949"; # Last commit before gtk deprecation
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    # central host table
    hosts = {
      desktop = {
        system = "x86_64-linux";
        user = "paul";
        impermanent = true;
      };
      laptop = {
        system = "x86_64-linux";
        user = "paul";
        impermanent = true;
      };
      macbook = {
        system = "aarch64-darwin";
        user = "paul.kratochwill";
        impermanent = false;
      };
    };

    # common specialArgs
    mkSpecialArgs = host: cfg: {
      pkgs = import nixpkgs {
        system = cfg.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
      inherit inputs;
      outputs = self.outputs;
      host = hosts.${host} // {name = host;};
    };

    # Base modules common to both NixOS and Darwin
    baseModules = host: [
      ./nixos/host-${host}.nix
      ./modules/core
      ./nixos/home-manager.nix
    ];

    # System-specific modules
    systemModules = {
      nixos = host: [
        inputs.home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
        inputs.catppuccin.nixosModules.catppuccin
      ];
      darwin = host: [
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.agenix.darwinModules.default
      ];
    };

    # Conditional impermanence module
    impermanenceModule = system: host:
      nixpkgs.lib.optionals hosts.${host}.impermanent [
        (
          if system == "nixos"
          then inputs.impermanence.nixosModules.impermanence
          else inputs.impermanence.darwinModules.impermanence
        )
      ];

    nixosModules = host:
      (baseModules host)
      ++ (systemModules.nixos host)
      ++ (impermanenceModule "nixos" host);

    darwinModules = host:
      (baseModules host)
      ++ (systemModules.darwin host)
      ++ (impermanenceModule "darwin" host);

    mkConfigs = systemType: systemBuilder:
      nixpkgs.lib.filterAttrs
      (n: _: nixpkgs.lib.strings.hasInfix systemType hosts.${n}.system)
      (nixpkgs.lib.mapAttrs'
        (host: cfg:
          nixpkgs.lib.nameValuePair host
          (systemBuilder {
            inherit host cfg;
            modules =
              if nixpkgs.lib.strings.hasInfix "darwin" cfg.system
              then darwinModules host
              else nixosModules host;
          }))
        hosts);

    mkConfiguredSystem = builder: { host, cfg, modules }:
      builder {
        system = cfg.system;
        specialArgs = mkSpecialArgs host cfg;
        inherit modules;
      };
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = mkConfigs "linux" (mkConfiguredSystem nixpkgs.lib.nixosSystem);
    darwinConfigurations = mkConfigs "darwin" (mkConfiguredSystem darwin.lib.darwinSystem);
  };
}

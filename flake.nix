{
  description = "Desktop nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # See the '(un)stable-packages' overlay at 'overlays/default.nix'.

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    # nix4nvchad
    nix4nvchad.url = "github:nix-community/nix4nvchad";
    nix4nvchad.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Secrets
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # declarative homebrew management (macOS)
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Styling
    #catppuccin.url = "github:catppuccin/nix/c4dac42a4fadc49bbd939fb3531673dbb3b0a949"; # Last commit before gtk deprecation
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager, ... } @ inputs:
    let
      systems = [
        "x86_64-linux" "aarch64-linux"
        "x86_64-darwin" "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # central host table
      hosts = {
        desktop  = { system = "x86_64-linux"; user = "paul"; impermanent = true; };
        laptop   = { system = "x86_64-linux"; user = "paul"; impermanent = true; };
        macbook  = { system = "aarch64-darwin"; user = "paul.kratochwill"; impermanent = false; };
      };

      # common specialArgs
      mkSpecialArgs = host: {
        inherit inputs;
        outputs = self.outputs;
        host = hosts.${host} // { name = host; };
      };

      # shared NixOS modules
      nixosModules = host: [
        ./nixos/host-${host}.nix
        ./modules/core
        ./nixos/home-manager.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.agenix.nixosModules.default
        inputs.catppuccin.nixosModules.catppuccin
      ] ++ (nixpkgs.lib.optionals hosts.${host}.impermanent [
        inputs.impermanence.nixosModules.impermanence
      ]);

      # shared Darwin modules
      darwinModules = host: [
        ./nixos/host-${host}.nix
        ./modules/core/default-darwin.nix
        ./nixos/home-manager.nix
        inputs.home-manager.darwinModules.home-manager
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.agenix.darwinModules.default
      ] ++ (nixpkgs.lib.optionals hosts.${host}.impermanent [
        inputs.impermanence.darwinModules.impermanence
      ]);
    in
    {
      packages   = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      formatter  = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
      overlays   = import ./overlays { inherit inputs; };

      nixosConfigurations = nixpkgs.lib.filterAttrs
        (n: _: hosts.${n}.system != "aarch64-darwin")
        (nixpkgs.lib.mapAttrs'
          (host: cfg: nixpkgs.lib.nameValuePair host
            (nixpkgs.lib.nixosSystem {
              system = cfg.system;
              specialArgs = mkSpecialArgs host;
              modules = nixosModules host;
            }))
          hosts);

      darwinConfigurations = nixpkgs.lib.filterAttrs
        (n: _: hosts.${n}.system == "aarch64-darwin")
        (nixpkgs.lib.mapAttrs'
          (host: cfg: nixpkgs.lib.nameValuePair host
            (darwin.lib.darwinSystem {
              system = cfg.system;
              specialArgs = mkSpecialArgs host;
              modules = darwinModules host;
            }))
          hosts);
    };
}

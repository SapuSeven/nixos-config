{
  description = "Paul BAWAG nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nix4nvchad
    nix4nvchad.url = "github:nix-community/nix4nvchad";
    nix4nvchad.inputs.nixpkgs.follows = "nixpkgs";

    # manages configs
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # system-level software and settings (macOS)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # declarative homebrew management
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    home-manager,
    nix-homebrew,
    ...
  }@inputs:
  let
    primaryUser = "paul.kratochwill";
    system = "aarch64-darwin";
    lib = darwin.lib;
    specialArgs = { inherit system inputs self primaryUser; };
  in
  {
    # Build darwin flake using:
    # $ sudo darwin-rebuild build --flake .#paul-kratochwill-bawag
    darwinConfigurations."paul-bawag" = lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./darwin
        ./hosts/paul-bawag/configuration.nix
      ];
      #specialArgs = { inherit inputs self primaryUser; };
    };
  };
}

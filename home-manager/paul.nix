{ inputs, outputs, lib, config, pkgs, ... }:
let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
    sha256 = "03bk3lak512nzz1a3kvdjkagyjdslvnp53h043l272wnk056abpc";
  };
in {
  # You can import other home-manager modules here
  imports = [
    "${impermanence}/home-manager.nix"

    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "paul";
    homeDirectory = "/home/paul";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  services = {
    mako = {
      enable = true;
      margin = "16";
      padding = "8";
      borderSize = 2;
      borderRadius = 2;
      font = "sans 12";
      defaultTimeout = 10000;
    };
    udiskie.enable = true;
  };

  home.persistence."/nix/persist/home/paul" = {
    allowOther = true;
    directories = [
      "Files"
      ".gnupg"
      ".ssh"
      ".config/keepassxc"
      ".config/syncthing"
      ".config/TeamSpeak"
    ];
    files = [ ".zsh_history" ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

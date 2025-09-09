{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  impermanence = builtins.fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
    sha256 = "04l16szln2x0ajq2x799krb53ykvc6vm44x86ppy1jg9fr82161c";
  };
in {
  # You can import other home-manager modules here
  imports = [
    "${impermanence}/home-manager.nix"

    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    inputs.agenix.homeManagerModules.default
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
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

  services.udiskie.enable = true;

  home.persistence."/nix/persist/home/paul" = {
    allowOther = true;
    directories = [
      "Files"
      ".gnupg" # Keyring
      ".ssh" # SSH keys and hosts
      ".config/keepassxc" # KeePassXC
      ".config/syncthing" # Syncthing
      ".config/TeamSpeak" # TeamSpeak
      ".config/Google" # Android Studio config
      ".local/state/wireplumber" # Audio setup
    ];
    files = [".zsh_history"];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

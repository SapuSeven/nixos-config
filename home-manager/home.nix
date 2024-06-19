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

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./kitty.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "paul";
    homeDirectory = "/home/paul";
  };

  catppuccin.enable = true;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "SapuSeven";
      userEmail = "sapuseven@gmail.com";
      extraConfig = {
        safe = { directory = "/etc/nixos/.git"; };
      };
    };
  };

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

  xresources.properties = {
    "Xft.antialias" = 1;
    "Xft.autohint" = 0;
    "Xft.dpi" = 192;
  };

  gtk.enable = true;
  gtk.catppuccin.enable = true;
#  gtk = {
#    enable = true;
#    theme = {
#      name = "Colloid-Purple-Dark";
#      package = pkgs.colloid-gtk-theme.override {
#        themeVariants = [ "purple" ];
#        colorVariants = [ "dark" ];
#        tweaks = [ "black" ];
#        #tweaks = [ "catppuccin" ];
#      };
#    };

#    iconTheme = {
#      package = (pkgs.papirus-icon-theme.override {
#        color = "violet";
#      });
#      name = "Papirus-Dark";
#    };

#    cursorTheme = {
#      package = pkgs.bibata-cursors;
#      name = "Bibata-Modern-Ice";
#    };

#    gtk3.extraConfig = {
#      Settings = ''
#        gtk-application-prefer-dark-theme=1
#      '';
#    };

#    gtk4.extraConfig = {
#      Settings = ''
#        gtk-application-prefer-dark-theme=1
#      '';
#    };
#  };

  qt = {
    enable = true;
    style.name = "kvantum";
    #platformTheme.name = "gtk";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  home.persistence."/nix/persist/home/paul" = {
    allowOther = true;
    directories = [
      "Files"
      ".gnupg"
      ".ssh"
    ];
    files = [ ".zsh_history" ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

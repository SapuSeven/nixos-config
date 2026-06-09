{
  config,
  pkgs,
  lib,
  host,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.overworld.home.catppuccin;
  flavor = "mocha";
  accent = "mauve";
  shade = "dark";

  themeColors = pkgs.fetchFromGitHub {
    owner = "claymorwan";
    repo = "catppuccin";
    rev = "d03125088f4fe9b7ec44aa8d3e2f0c42abcdb7a1";
    sha256 = "sha256-ELpzK2vx7O/GFwGzdTrYQa7mvGQDxCzJoW3QRkCUcao=";
  };

  cursor-pkg = pkgs.bibata-cursors;
in {
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = flavor;
    accent = "mauve";
  };

  xresources.properties = {
    "Xft.antialias" = 1;
    "Xft.autohint" = 0;
    "Xft.dpi" =
      if host == "laptop"
      then 120
      else 192;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        scaling-factor = "1.25";
      };
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      package = cursor-pkg;
      name = "Bibata-Modern-Ice";
    };

    gtk3 = {
      extraCss = builtins.readFile "${themeColors}/adw/themes/${flavor}/catppuccin-${flavor}-${accent}.css";
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    gtk4 = {
      extraCss = builtins.readFile "${themeColors}/adw/themes/${flavor}/catppuccin-${flavor}-${accent}.css";
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = cursor-pkg;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}

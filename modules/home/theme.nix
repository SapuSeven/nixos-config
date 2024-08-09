{ config, pkgs, lib, host, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.overworld.home.catppuccin;
  gradiencePreset = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/GradienceTeam/Community/next/official/catppuccin-mocha.json";
    hash = "sha256-4/RVQF6irDueswEXWtmn2CCmyN7VQtQPrDAeg45cTPk=";
  };
  gradienceBuild = pkgs.stdenv.mkDerivation {
    name = "gradience-build";
    phases = [
      "buildPhase"
      "installPhase"
    ];
    nativeBuildInputs = [ pkgs.gradience ];
    buildPhase = ''
      shopt -s nullglob
      export HOME=$TMPDIR
      mkdir -p $HOME/.config/presets
      gradience-cli apply -p ${gradiencePreset} --gtk both
    '';
    installPhase = ''
      mkdir -p $out
      cp -r .config/gtk-4.0 $out/
      cp -r .config/gtk-3.0 $out/
    '';
  };
in
{
  catppuccin.enable = true;

  xresources.properties = {
    "Xft.antialias" = 1;
    "Xft.autohint" = 0;
    "Xft.dpi" = if host=="laptop" then 120 else 192;
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

    catppuccin = {
      enable = false;
      icon.enable = true;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    gtk3 = {
      extraCss = builtins.readFile "${gradienceBuild}/gtk-3.0/gtk.css";
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };

    gtk4 = {
      extraCss = builtins.readFile "${gradienceBuild}/gtk-4.0/gtk.css";
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
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}

{ pkgs, ... }:
{
  catppuccin.enable = true;

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
    platformTheme.name = "gtk";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}

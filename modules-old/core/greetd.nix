{pkgs, ...}: {
  services.greetd = {
    enable = true;

    settings = {
#      initial_session = {
#        command = "start-hyprland";
#        user = host.user;
#      }
    };
  };

  services.displayManager.regreet = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    settings = {
      skip_selection = true;
      background = {
        #path = "/path/to/your/wallpaper.png";
        fit = "Cover";
      };
    };
  };
}

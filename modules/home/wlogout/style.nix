{
  lib,
  pkgs,
  ...
}: let
  src = builtins.fetchGit {
    url = "https://github.com/4w4z4rd/wlogout.git"; # This fork contains improved icons
    rev = "91b009f3351d189616cbd7f61b0a7cbf9fb78e1f";
  };
  theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/waybar/main/themes/mocha.css";
    sha256 = "05yx7v4j9k1s1xanlak7yngqfwvxvylwxc2fhjcfha68rjbhbqx6";
  };
in {
  programs.wlogout.style = lib.mkForce ''
    @import "${theme}";

    * {
      background-image: none;
    }

    window {
      background-color: rgba(36, 39, 58, 0.9);
    }

    button {
      margin: 8px;
      color: @rosewater;
      border-style: solid;
      border-width: 3px;
      background-color: @surface0;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 25%;
    }

    button:active,
    button:focus,
    button:hover {
      color: @mauve;
      outline-style: none;
      border-color: @mauve;
    }

    #lock {
      background-image: image(url("${src}/icons/lock.png"));
    }

    #logout {
      background-image: image(url("${src}/icons/logout.png"));
    }

    #suspend {
      background-image: image(url("${src}/icons/suspend.png"));
    }

    #hibernate {
      background-image: image(url("${src}/icons/hibernate.png"));
    }

    #shutdown {
      background-image: image(url("${src}/icons/shutdown.png"));
    }

    #reboot {
      background-image: image(url("${src}/icons/reboot.png"));
    }
  '';
}

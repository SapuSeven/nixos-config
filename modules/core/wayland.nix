{inputs, pkgs, ...}: {
  imports = [ inputs.hyprland.nixosModules.default ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      hyprland.default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  programs = {
    hyprland = let
      hyprpkgs = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}";
    in {
      enable = true;
      withUWSM = true;
      package = hyprpkgs.hyprland;
      portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
  
    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/start-hyprland";
        };
      };
    };
  };

  # Enable the X11 windowing system (for XWayland).
  services.xserver = {
    enable = true;
    updateDbusEnvironment = true;

    # Enable display manager.
    #services.xserver.displayManager.gdm.enable = true;
    #services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "compose:ralt";
    };
  };
}

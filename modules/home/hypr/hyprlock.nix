# Focus issue after unlocking:
# https://github.com/hyprwm/hyprlock/issues/347

{ config, pkgs, ... }:
let
  inherit (config.catppuccin) sources;
  cfg = config.wayland.windowManager.hyprland.catppuccin;
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Gingeh/wallpapers/main/os/nix-black-4k.png";
    sha256 = "7b54417798130689c6dfd8189b10af26e7fea993a2bb1799f4b4e384f401f6f9";
  };
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      source = [
        "${sources.hyprland}/themes/${cfg.flavor}.conf"
        (builtins.toFile "hyprland-${cfg.accent}-accent.conf" ''
          $accent=''$${cfg.accent}
          $accentAlpha=''$${cfg.accent}Alpha
        '')
      ];

      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        # BACKGROUND
        {
          monitor = "";
          path = "${wallpaper}";
          color = "$base";
        }
      ];

      label = [
        # TIME
        {
          monitor = "";
          text = "cmd[update:30000] echo \"$(date +\"%R\")\"";
          color = "$text";
          font_size = 90;
          font_family = "$font";
          position = "0, -100";
          halign = "center";
          valign = "top";
          shadow_passes = 2;
        }

        # DATE 
        {
          monitor = "";
          text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
          color = "$text";
          font_size = 25;
          font_family = "$font";
          position = "0, -250";
          halign = "center";
          valign = "top";
          shadow_passes = 2;
        }
      ];

#      image = [
        # USER AVATAR
#        {
#          monitor = "";
#          path = "$HOME/.face";
#          size = 350;
#          border_color = "$accent";
#          rounding = -1;

#          position = "0, 75";
#          halign = "center";
#          valign = "center";
#          shadow_passes = 2;
#        }
#      ];

      input-field = [
        # PASSWORD INPUT
        {
          monitor = "DP-1";
          size = "600, 100";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$surface0";
          font_color = "$text";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##$textAlpha\"><b>󰌾  Locked</b></span>";
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, 300";
          halign = "center";
          valign = "bottom";
          shadow_passes = 2;
        }
        {
          monitor = "eDP-1";
          size = "400, 80";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "$accent";
          inner_color = "$surface0";
          font_color = "$text";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##$textAlpha\"><b>󰌾  Locked</b></span>";
          hide_input = false;
          check_color = "$accent";
          fail_color = "$red";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "$yellow";
          position = "0, 200";
          halign = "center";
          valign = "bottom";
          shadow_passes = 2;
        }
      ];
    };
  };
}

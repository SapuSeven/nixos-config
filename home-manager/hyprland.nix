{ pkgs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      "$mod" = "SUPER";

      monitor = [
        "DP-1,highres,1920x0,1.875"
        "HDMI-A-1,preferred,0x0,1"
        "DP-2,preferred,3968x0,1,transform,1"
      ];

      workspace = [
        "1, monitor:DP-1, default:true"
        "workspace=2, monitor:HDMI-A-1"
        "workspace=3, monitor:DP-2"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 8;
        border_size = 2;
        #"col.active_border" = "rgba(962ac3ee) rgba(ff2abbee) 45deg";
        #"col.inactive_border" = "rgba(595959aa)";
        "col.active_border" = "0xee$accentAlpha";
        "col.inactive_border" = "0xee$surface0Alpha";

        layout = "dwindle";
      };

      misc = {
        disable_hyprland_logo = true;
        background_color = "$base";
      };

      decoration = {
        rounding = 4;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 3;
        "col.shadow" = "0x88$accentAlpha";
        "col.shadow_inactive" = "0x00000000";
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds sectio>
        preserve_split = "yes"; # you probably want this
        smart_split = true;
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = "on";
      };

      animation = [
        "global,1,3,default"
      ];

      windowrulev2 = [
        "noinitialfocus,class:^jetbrains-(?!toolbox),floating:1" # See https://github.com/hyprwm/Hyprland/issues/2412
        "float,class:udiskie"
      ];

      exec-once = [
        "hyprpaper"
      ];

      bind = [
        # Program shortcuts
        "$mod, return, exec, kitty"
        "$mod, E, exec, thunar"
        "$mod, F, exec, firefox"
        "CTRL SHIFT, P, exec, firefox -private-window"

        # Close active window
        "$mod, Q, killactive,"

        # Open menu
        "$mod, D, exec, wofi --show drun"

        # Resize windows
        "$mod, space, togglefloating,"
        "$mod SHIFT, F, fullscreen"

        # Move focus with mod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move windows with mod + shift + arrow keys
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Move workspaces
        "$mod CTRL, left, movecurrentworkspacetomonitor, l"
        "$mod CTRL, right, movecurrentworkspacetomonitor, r"

        # Hypr-Utils
        "$mod, Tab, exec, hyprlock"

        # Exit hyprland
        "$mod SHIFT, E, exit"

        # Media controls
        ", F86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Touchpad controls
        ", XF86TouchpadToggle, exec, touchpad-toggle.sh"

        # Power button
        ", XF86PowerOff, exec, powermenu"

        # Mako
        "Ctrl, Space, exec, makoctl dismiss"
        "Ctrl Shift, Space, exec, makoctl dismiss -a"
        "Ctrl, Less, exec, makoctl restore"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );

      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      
      bindr = [
        # Media controls
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +2%"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -2%"

        # Screen brightness controls
        ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
    };
  };
}


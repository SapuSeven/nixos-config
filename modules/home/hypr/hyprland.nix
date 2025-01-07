{
  pkgs,
  host,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    xclip
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      debug = {
        disable_logs = false;
      };

      "$mod" = "SUPER";

      monitor =
        if host == "laptop"
        then [
          "eDP-1,preferred,0x0,1.25,mirror,HDMI-A-1"
        ]
        else [
          "desc:Dell Inc. DELL S2721QS DVG9M43,highres,1920x0,1.875"
          "desc:Ancor Communications Inc VG248 H4LMQS170852,preferred,0x0,1"
          "desc:Hewlett Packard LA2205 3CQ9461SLN,preferred,3968x0,1,transform,1"
        ];

      xwayland = {
        force_zero_scaling = true;
      };

      workspace =
        if host == "laptop"
        then [
          "1, monitor:eDP-1, default:true"
        ]
        else [
          "1, monitor:desc:Dell Inc. DELL S2721QS DVG9M43, default:true"
          "2, monitor:desc:Ancor Communications Inc VG248 H4LMQS170852"
          "3, monitor:desc:Hewlett Packard LA2205 3CQ9461SLN"
        ];

      general = {
        gaps_in = 2;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "0xee$accentAlpha";
        "col.inactive_border" = "0xee$surface0Alpha";

        layout = "dwindle";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        background_color = "$base";
      };

      input = {
        touchpad = {
          scroll_factor = 0.5;
          natural_scroll = true;
        };
        numlock_by_default = true;
      };

      device = [
        {
          # laptop touchpad
          name = "syna32a5:00-06cb:ce17-touchpad";
          sensitivity = 0.2;
        }
      ] ++ map (dev: { name = dev; sensitivity = -1; }) [
        "razer-viper-v3-pro"
        "razer-viper-v3-pro-1"
        "razer-razer-viper-v3-pro"
        "razer-razer-viper-v3-pro-1"
        "razer-razer-viper-v3-pro-mouse"
      ];

      decoration = {
        rounding = 4;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        shadow = {
          enabled = true;
          range = 8;
          render_power = 3;
          color = "0x88$accentAlpha";
          color_inactive = "0x00000000";
        };
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds sectio>
        preserve_split = "yes"; # you probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_status = "master";
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

      exec = [
        "xrdb -merge \"$HOME/.Xresources\""
      ];

      exec-once = [
        "hyprpaper"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "avizo-service"
      ];

      bind =
        [
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
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioStop, exec, playerctl stop"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"

          # Screen brightness controls
          ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"

          # Touchpad controls
          #", XF86TouchpadToggle, exec, touchpad-toggle.sh"

          # Power button
          ", XF86PowerOff, exec, wlogout"

          # Mako
          "Ctrl, Space, exec, makoctl dismiss"
          "Ctrl Shift, Space, exec, makoctl dismiss -a"
          "Ctrl, Less, exec, makoctl restore"

          # Clipboard
          "$mod, V, exec, cliphist list | wofi -S dmenu | cliphist decode | wl-copy"
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
        #", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +2%"
        #", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -2%"
      ];
    };
  };
}

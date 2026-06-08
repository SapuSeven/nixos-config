{
  lib,
  pkgs,
  host,
  ...
}: let
  scripts = pkgs.writeShellScriptBin "osd" ''
    #!/usr/bin/env bash
    value_threshold() {
      local LOW_THRESHOLD=0.33
      local HIGH_THRESHOLD=0.66

      if (( $(echo "$1 < $LOW_THRESHOLD" | ${pkgs.bc}/bin/bc -l) )); then
        echo "low"
      elif (( $(echo "$1 >= $LOW_THRESHOLD" | ${pkgs.bc}/bin/bc -l) && $(echo "$1 < $HIGH_THRESHOLD" | ${pkgs.bc}/bin/bc -l) )); then
        echo "medium"
      else
        echo "high"
      fi
    }

    if [[ "$1" == "volume" ]]; then
      volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

      case "$volume" in
        *MUTED*) avizo-client --image-resource=volume_muted_dark ;;
        *)
          volume="''${volume##* }"
          # TODO: Use --image-resource="" and --image-path="*.svg" for custom images
          avizo-client --image-resource=volume_$(value_threshold "$volume")_dark --progress ''${volume}
          ;;
      esac
    elif [[ "$1" == "brightness" ]]; then
      brightness=$(echo "scale=2; $(brightnessctl g) / 255" | ${pkgs.bc}/bin/bc)
      avizo-client --image-resource=brightness_$(value_threshold "$brightness")_dark --progress ''${brightness}
    fi
  '';
  browser = "zen-twilight"; # Provided externally

  # Hyprland config utils
  lua = lib.generators.mkLuaInline;
  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    float = lua ''hl.dsp.window.float({ action = "toggle" })'';
    fullscreen = lua "hl.dsp.window.fullscreen()";
    pseudo = lua "hl.dsp.window.pseudo()";
    layout = msg: lua ''hl.dsp.layout("${msg}")'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    move = dir: lua ''hl.dsp.window.move({ direction = "${dir}" })'';
    swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
    toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
    moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
    moveWorkspace = dir: lua ''hl.dsp.workspace.move({ monitor = "${dir}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
    sendshortcut = mod: key: lua ''hl.dsp.send_shortcut({ mods = "${mod}", key = "${key}" })'';
  };

  bind = keys: dispatcher: { _args = [keys dispatcher]; };
  bindOpts = keys: dispatcher: opts: { _args = [keys dispatcher opts]; };

  workspaceBinds = lib.concatMap (i:
      let key = toString (lib.mod i 10);
      in [
        (bind "SUPER + ${key}" (dsp.focusWorkspace i))
        (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
      ]
    ) (lib.range 1 10);
in {
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    xclip
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Conflicts with UWSM

    # Handled by NixOS module
    package = null;
    portalPackage = null;
    
    settings = {
      mod = {
        _var = "SUPER";
      };

      monitor =
        if host == "laptop"
        then [
          {
            output = "eDP-1";
            mode = "preferred";
            position = "0x0";
            scale = 1.25;
            mirror = "HDMI-A-1";
          }
        ]
        else [
          {
            output = "desc:Dell Inc. DELL S2721QS DVG9M43";
            mode = "highres";
            position = "1920x0";
            scale = 1.875;
          }
          {
            output = "desc:Ancor Communications Inc VG248 H4LMQS170852";
            mode = "preferred";
            position = "0x0";
            scale = 1;
          }
          {
            output = "desc:Hewlett Packard LA2205 3CQ9461SLN";
            mode = "preferred";
            position = "3968x0";
            scale = 1;
            transform = 1;
          }
        ];

      config = {
        general = {
          gaps_in = 2;
          gaps_out = 8;
          border_size = 2;
          col = {
            active_border = (lua ''"0xee" .. colors.accentAlpha'');
            inactive_border = (lua ''"0xee" .. colors.surface0Alpha'');
          };
        };

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
            color = (lua ''"0x88" .. colors.accentAlpha'');
            color_inactive = "0x00000000";
          };
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          preserve_split = true;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          background_color = (lua ''colors.base'');
        };

        input = {
          kb_layout = "us";
          kb_options = "compose:ralt";
          numlock_by_default = true;
          mouse_refocus = false;

          touchpad = {
            scroll_factor = 0.5;
            natural_scroll = true;
          };
        };
      };

      workspace_rule =
        if host == "laptop"
        then [{
          workspace = "1";
          monitor = "eDP-1";
          default = true;
        }]
        else [{
          workspace = "1";
          monitor = "DP-1";
          default = true;
        }
        {
          workspace = "2";
          monitor = "HDMI-A-1";
        }
        {
          workspace = "3";
          monitor = "DP-2";
        }];

      device =
        [
          {
            # laptop touchpad
            name = "syna32a5:00-06cb:ce17-touchpad";
            sensitivity = 0.2;
          }
        ]
        ++ map (dev: {
          name = dev;
          sensitivity = -0.6;
        }) [
          "razer-viper-v3-pro"
          "razer-viper-v3-pro-1"
          "razer-viper-v3-pro-2"
          "razer-viper-v3-pro-3"
          "razer-razer-viper-v3-pro"
          "razer-razer-viper-v3-pro-1"
          "razer-razer-viper-v3-pro-2"
          "razer-razer-viper-v3-pro-3"
          "razer-razer-viper-v3-pro-mouse"
        ];

      gesture = [{
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      }];

      animation = [{
        leaf = "global";
        enabled = true;
        speed = 3;
        bezier = "default";
      }];

      window_rule = [
        # Fixes for Jetbrains IDEs - see https://github.com/hyprwm/Hyprland/issues/4257
        {
          # Fix tooltips (always have a title of `win<id>`)
          match = {
            class = "^(.*jetbrains.*)$";
            title = "^(win.*)$";
            float = true;
          };
          no_focus = true;
        }
        {
          # fix tab dragging (always have a single space character as their title)
          match = {
            class = "^(.*jetbrains.*)$";
            title = "^\\s$";
          };
          no_focus = true;
        }

        {
          match = {
            class = "udiskie";
          };
          float = true;
        }
        {
          match = {
            class = "thunar";
            title = "File Operation Progress";
          };
          float = true;
        }
        {
          match = {
            class = "thunar";
            title = "^(Rename \".*\")$";
          };
          float = true;
        }
        {
          match = {
            class = "thunar";
            title = "^(Rename \".*\")$";
          };
          float = true;
        }

        {
          # Keep Terraria in fullscreen on focus loss
          match = {
            fullscreen_state_client = "[1-3]";
            initial_title = "^(Terraria)$";
          };
          fullscreen_state = 3;
        }
      ];

      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              ${lib.concatMapStringsSep "\n" (cmd: "hl.exec_cmd(\"${cmd}\")") [
                "uwsm finalize"
                "wl-paste --type text --watch cliphist store"
                "wl-paste --type image --watch cliphist store"
                "avizo-service"
                "xrdb -merge \\\"$HOME/.Xresources\\\""
              ]}
            end
          '')
        ];
      };

      bind = [
        # ── Program shortcuts ──────────────────────────────────────
        (bind "SUPER + RETURN" (dsp.exec "kitty"))
        (bind "SUPER + E" (dsp.exec "thunar"))
        (bind "SUPER + F" (dsp.exec "${browser}"))
        (bind "CTRL + SHIFT + P" (dsp.exec "${browser} -private-window"))

        # ── Close active window ───────────────────────────────────
        (bind "SUPER + Q" dsp.close)

        # ── Open menu ─────────────────────────────────────────────
        (bind "SUPER + D" (dsp.exec "wofi --show drun"))

        # ── Float / fullscreen ─────────────────────────────────────
        (bind "SUPER + SPACE" dsp.float)
        (bind "SUPER + SHIFT + F" dsp.fullscreen)

        # ── Move focus with SUPER + arrow keys ───────────────────────
        (bind "SUPER + LEFT"  (dsp.focus "left"))
        (bind "SUPER + RIGHT" (dsp.focus "right"))
        (bind "SUPER + UP"    (dsp.focus "up"))
        (bind "SUPER + DOWN"  (dsp.focus "down"))

        # ── Move windows with SUPER + shift + arrow keys ─────────────
        (bind "SUPER + SHIFT + LEFT"  (dsp.move "left"))
        (bind "SUPER + SHIFT + RIGHT" (dsp.move "right"))
        (bind "SUPER + SHIFT + UP"    (dsp.move "up"))
        (bind "SUPER + SHIFT + DOWN"  (dsp.move "down"))

        # ── Scroll through workspaces with SUPER + scroll ────────────
        (bind "SUPER + mouse_down" (dsp.focusWorkspace "e+1"))
        (bind "SUPER + mouse_up" (dsp.focusWorkspace "e-1"))

        # ── Move workspaces between monitors ────────────────────────
        (bind "SUPER + CTRL + LEFT"  (dsp.moveWorkspace "left"))
        (bind "SUPER + CTRL + RIGHT" (dsp.moveWorkspace "right"))

        # ── Hyprlock / exit ────────────────────────────────────────
        (bind "SUPER + TAB"      (dsp.exec "hyprlock"))
        (bind "SUPER + SHIFT + E" dsp.exit)

        # ── Media controls ──────────────────────────────────────────
        (bindOpts "XF86AudioRaiseVolume" (dsp.exec "wpctl set-volume @ 5%+ && ${scripts}/bin/osd volume") { locked = true; repeating = true; })
        (bindOpts "XF86AudioLowerVolume" (dsp.exec "wpctl set-volume @ 5%- && ${scripts}/bin/osd volume") { locked = true; repeating = true; })
        (bindOpts "XF86AudioMute" (dsp.exec "wpctl set-mute @ toggle && ${scripts}/bin/osd volume") { locked = true; })
        (bindOpts "XF86AudioMicMute" (dsp.exec "wpctl set-mute u/DEFAULT_AUDIO_SOURCE@ toggle && ${scripts}/bin/osd volume") { locked = true; })
        (bind "XF86AudioPlay"    (dsp.exec "playerctl play-pause"))
        (bind "XF86AudioStop"    (dsp.exec "playerctl stop"))
        (bind "XF86AudioNext"    (dsp.exec "playerctl next"))
        (bind "XF86AudioPrev"    (dsp.exec "playerctl previous"))

        # ── Power button ───────────────────────────────────────────
        (bind "XF86PowerOff" (dsp.exec "wlogout"))

        # ── Clipboard ─────────────────────────────────────────────
        (bind "SUPER + V" (dsp.exec "cliphist list | wofi -S dmenu | cliphist decode | wl-copy"))

        # ── Notifications ─────────────────────────────────────────
        (bindOpts "CTRL + SPACE"                 (dsp.exec "makoctl dismiss")    { non_consuming = true; })
        (bindOpts "CTRL + SHIFT + SPACE"         (dsp.exec "makoctl dismiss -a") { non_consuming = true; })
        (bindOpts "CTRL + SHIFT + ALT_L + SPACE"  (dsp.exec "makoctl restore")    { non_consuming = true; })

        # ── Mouse binds ──────────────────────────────────────────────────
        (bindOpts "SUPER + mouse:272" dsp.drag { mouse = true; })
        (bindOpts "SUPER + mouse:273" dsp.resize { mouse = true; })
      ] ++ workspaceBinds;
    };
  };
}

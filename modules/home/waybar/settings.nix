{ ... }:
{
  programs.waybar.settings.mainBar = {
    position = "bottom";
    layer = "top";
    height = 36;
    spacing = 4;
    modules-left= [
        #"custom/launcher" 
        "hyprland/workspaces"
    ];
    modules-center = [
        "clock#time"
        "custom/separator"
        "clock#week"
        "custom/separator_dot"
        "clock#month"
        "custom/separator"
        "clock#calendar"
    ];
    modules-right = [
        "tray" 
        "group/connectivity"
        "group/system"
        "group/misc"
        "custom/power"
    ];

    "clock#time" = {
        format = "{:%H:%M}";
        # "locale": "en_US.UTF-8",
        # "timezones": [ "Europe/Kyiv", "America/New_York" ],
    };

    "custom/separator" = {
        format = "|";
        tooltip = false;
    };

    "custom/separator_dot" = {
        "format" = "•";
        "tooltip" = false;
    };

    "clock#week" = {
        format = "{:%a}";
    };

    "clock#month" = {
        format = "{:%h}";
    };

    "clock#calendar" = {
        format = "{:%F}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        actions = {
            on-click-right = "mode";
        };
        calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
                months = "<span color='#f4dbd6'><b>{}</b></span>";
                days = "<span color='#cad3f5'>{}</span>";
                weeks = "<span color='#c6a0f6'><b>W{}</b></span>";
                weekdays = "<span color='#a6da95'><b>{}</b></span>";
                today = "<span color='#8bd5ca'><b><u>{}</u></b></span>";
            };
        };
    };

    clock = {
        calendar = {
          format = { today = "<span color='#b4befe'><b><u>{}</u></b></span>"; };
        };
        format = "  {:%H:%M}";
        tooltip= "true";
        tooltip-format= "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt= "  {:%d.%m.}";
    };

    "hyprland/workspaces"= {
        active-only = false;
        all-outputs = true;
        disable-scroll = true;
        format = "{icon}";
        on-click= "activate";
        format-icons= {
            default = "";
            active = "";
            empty = "";
            urgent = "";
            sort-by = "number";
        };
    };

    memory = {
        format = " {}%";
        format-alt = " {used} GiB"; # 󰟜
        interval = 2;
    };

    cpu = {
        format = " {usage}%";
        format-alt = " {avg_frequency} GHz";
        interval = 2;
    };

    disk = {
        path = "/nix";
        format = "󰋊 {percentage_used}%";
        interval = 60;
    };

    network = {
        format-wifi = "{icon} {essid}"; # 
        format-ethernet = "󰀂";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
        tooltip-format = "Interface: {ifname}\nIP: {ipaddr}\nGW: {gwaddr}\n\n<span color='#a6da95'>{bandwidthUpBits}</span>\t<span color='#ee99a0'>{bandwidthDownBits}</span>\t<span color='#c6a0f6'>󰹹{bandwidthTotalBits}</span>";
        tooltip-format-wifi = "SSID: {essid} ({signalStrength}%), {frequency} MHz\nInterface: {ifname}\nIP: {ipaddr}\nGW: {gwaddr}\n\n<span color='#a6da95'>{bandwidthUpBits}</span>\t<span color='#ee99a0'>{bandwidthDownBits}</span>\t<span color='#c6a0f6'>󰹹{bandwidthTotalBits}</span>";
        tooltip-format-disconnected = "<span color='#ed8796'>disconnected</span>";
        format-linked = "{ifname} (No IP)";
        format-disconnected = "󰤭"; # 󰖪
    };

    tray = {
        icon-size = 20;
        spacing = 8;
    };

    pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰖁 {volume}%";
        format-icons = [ "󰕿" "󰖀" "󰕾" ];
        scroll-step = 2;
        on-click = "pavucontrol";
    };

    battery = {
        format = "{icon} {capacity}%";
        format-icons = [" " " " " " " " " "];
        format-charging = " {capacity}%";
        format-full = " {capacity}%";
        format-warning = " {capacity}%";
        interval = 5;
        states = {
            warning = 20;
        };
        format-time = "{H}h{M}m";
        tooltip = true;
        tooltip-format = "{time}";
    };

    temperature = {
        tooltip = false;
        thermal-zone = 8;
        critical-threshold = 80;
        format = "{icon}{temperatureC}󰔄";
        format-icons = [ "" "" "" "" "" ];
    };

    idle_inhibitor = {
        format = "{icon}";
        format-icons = {
            activated = "󰛐 ";
            deactivated = "󰛑 ";
        };
        tooltip-format-activated = "idle-inhibitor <span color='#a6da95'>on</span>";
        tooltip-format-deactivated = "idle-inhibitor <span color='#ee99a0'>off</span>";
        start-activated = true;
    };

    "custom/launcher"= {
        format= "";
        on-click= "pkill wofi || wofi --show drun";
        on-click-right= "pkill wofi || wallpaper-picker"; 
        tooltip= "false";
    };

    "custom/power" = {
        return-type = "json";
        exec = "echo '{ \"text\":\"󰐥\", \"tooltip\": \"logout menu\" }'";
        interval = "once";
        on-click = "bash -c wlogout_uniqe";
    };

    "group/system" = {
      orientation = "inherit";
      modules = [
        "cpu"
        "memory"
        "disk"
        #"temperature"
        "pulseaudio" 
        "battery"
      ];
    };

    "group/connectivity" = {
      orientation = "inherit";
      modules = [
        #"bluetooth"
        "network"
      ];
    };

    "group/misc" = {
      orientation = "inherit";
      modules = [
        "idle_inhibitor"
      ];
    };
  };
}

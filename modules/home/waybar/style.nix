{ pkgs, ... }:
{
  programs.waybar.style = ''
    * {
        border: none;
        font-family: "monospace";
    }

    window#waybar {
      background-color: alpha(@base, 0.7);
      border-top: solid alpha(@surface1, 0.7) 2;
    }

    window .modules-center {
      font-weight: bold;
      background-color: alpha(@surface1, 0.7);
      color: @peach;
      border-radius: 1em;
      padding: 0 20px;
      margin: 5px 0;
    }

    #workspaces {
      margin-left: 10px;
    }

    #workspaces button.active {
      color: @mauve;
    }

    #workspaces button {
      color: @text;
    }

    #custom-separator {
      color: @green;
    }

    #custom-separator_dot {
      color: @green;
    }

    #clock.time {
      color: @flamingo;
    }

    #clock.week {
      color: @sapphire;
    }

    #clock.month {
      color: @sapphire;
    }

    #clock.calendar {
      color: @mauve;
    }

    #custom-power {
      color: @red;
      background-color: alpha(@surface1, 0.7);
      border-radius: 15 0 0 15;
      padding: 0 15px 0 10px;
      margin: 5px 0;
    }

    #cpu, #memory, #disk, #temperature, #pulseaudio, #backlight, #battery, #network, #bluetooth, #misc {
      color: @text;
      margin: 0;
      padding: 0 7px;
    }

    #cpu.high {
      color: @red;
    }

    #memory.high {
      color: @red;
    }

    #temperature {
      margin: 0 5px;
    }

    #temperature.critical {
      color: @red;
    }

    #battery.low {
      color: @red;
    }

    #battery.high {
      color: @green;
    }

    #battery.charging {
      color: @yellow;
    }

    #pulseaudio.bluetooth {
      color: @sapphire;
    }

    #pulseaudio.muted {
      color: @surface2;
    }

    #network, #idle_inhibitor {
      padding: 0 3px 0 0;
    }

    /* Groups */
    #system, #connectivity {
      background-color: alpha(@surface1, 0.7);
      border-radius: 1em;
      margin: 5px 2px;
      padding: 0 10px;
    }
    #tray {
      padding: 0 10px;
    }
  '';
}

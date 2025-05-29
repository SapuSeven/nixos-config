{host,...}: let
  timeout = if host == "laptop" then 600 else 1800; # laptop/desktop 10min/30min
  timeoutSuspend = if host == "laptop" then 1800 else 0; # laptop/desktop 30min/none
  suspend = "systemctl suspend-then-hibernate";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener =
        [
          {
            # Dim screen
            timeout = 300; # 5min
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            # Turn off display
            inherit timeout;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
          {
            # Lock
            timeout = timeout + 10;
            on-timeout = "loginctl lock-session";
          }
        ]
        ++ (
          if timeoutSuspend != 0
          then [
            {
              # Suspend
              timeout = timeoutSuspend;
              on-timeout = suspend;
            }
          ]
          else []
        );
    };
  };
}

{ pkgs, config, ... }:
{
  home.file."${config.xdg.configHome}/wluma/config.toml".text = ''
#[als.webcam]
#video = 0
#thresholds = { 0 = "night", 15 = "dark", 30 = "dim", 45 = "normal", 60 = "bright", 75 = "outdoors" }

[als.time]
thresholds = { 0 = "night", 7 = "dark", 9 = "dim", 11 = "normal", 13 = "bright", 16 = "normal", 18 = "dark", 20 = "night" }

#[als.none]

[[output.backlight]]
name = "eDP-1"
path = "/sys/class/backlight/amdgpu_bl2"
capturer = "wlroots"
  '';

  systemd.user.services.wluma = {
    Unit = {
      Description = "wluma automatic brightness adjustment";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wluma}/bin/wluma";
    };
  };
}

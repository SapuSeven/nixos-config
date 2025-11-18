{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    doas
    doas-sudo-shim
  ];

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = ["wheel"];
          keepEnv = true;
          noPass = true;
        }
      ];
    };
    sudo.enable = false;

    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
               action.id == "org.freedesktop.udisks2.filesystem-mount") &&
               subject.isInGroup("wheel")) {
            return polkit.Result.YES;
          }
        });
      '';
    };

    pki.certificateFiles = [../../../certs/LAN+Root+CA.crt];

    pam = {
      loginLimits = [
        {
          domain = "*";
          item = "nofile";
          type = "soft";
          value = "32768";
        }
        {
          domain = "*";
          item = "nofile";
          type = "hard";
          value = "32768";
        }
      ];
    };
  };

  systemd.user.extraConfig = "DefaultLimitNOFILE=32768";

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "Polkit-Gnome authentication agent";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}

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
          type = "-";
          value = "32768";
        }
        {
          domain = "*";
          item = "memlock";
          type = "-";
          value = "131072";
        }
      ];
    };
  };
}

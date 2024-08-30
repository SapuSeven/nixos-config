{...}: {
  # Security setup
  security.doas.enable = true;
  #security.sudo.enable = false;
  security.doas.extraRules = [
    {
      groups = ["wheel"];
      keepEnv = true;
      noPass = true;
    }
  ];
  security.polkit = {
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
  security.pki.certificateFiles = [../../../certs/LAN+Root+CA.crt];
}

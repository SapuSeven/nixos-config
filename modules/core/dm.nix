{pkgs, ...}: {
  # Enable display manager.
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
  };
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "paul";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}

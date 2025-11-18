{pkgs, ...}: {
  services.udev = {
    packages = [pkgs.yubikey-personalization];

    # Lock screen when unplugging yubikey
    extraRules = ''
      ACTION=="remove",\
       ENV{ID_BUS}=="usb",\
       ENV{ID_VENDOR_ID}=="1050",\
       ENV{ID_VENDOR}=="Yubico",\
       RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
    '';
  };

  # GPG and SSH
  programs.gnupg.agent = {
    #enable = true;
    #enableSSHSupport = true;
  };

  # Login via pam_u2f
  # FIXME Don't forget to create an authorization mapping file for your user (https://nixos.wiki/wiki/Yubikey#pam_u2f)
  security.pam.services = {
    login.u2fAuth = true;
    hyprlock.u2fAuth = true;
  };
}

{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zfs

    # system tools
    wget
    file

    # essentials
    git
    kitty

    # usb and automount
    usbutils
    udiskie
    udisks

    # desktop
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    wofi

    # audio
    playerctl
    pavucontrol

    # misc
    wluma
  ];
}

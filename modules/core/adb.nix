{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    android-tools
  ];

  # TODO: Still needed?
  services.udev.extraRules = let
    # nix-shell -p usbutils --run "lsusb"
    idVendor = "18d1";
    idProduct = "4ee7";
  in ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", MODE="[]", GROUP="adbusers", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", ATTR{idProduct}=="${idProduct}", SYMLINK+="android_adb"
    SUBSYSTEM=="usb", ATTR{idVendor}=="${idVendor}", ATTR{idProduct}=="${idProduct}", SYMLINK+="android_fastboot"
  '';

  users.users.paul.extraGroups = [
    "adbusers"
    "kvm"
  ];
}

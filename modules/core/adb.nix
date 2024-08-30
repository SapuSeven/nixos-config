{pkgs, ...}: {
  # Setup ADB
  programs.adb.enable = true;
  users.users.paul.extraGroups = [
    "adbusers"
    "kvm"
  ];
}

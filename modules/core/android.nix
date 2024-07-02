{ pkgs, ... }:
{
  # Setup ADB
  programs.adb.enable = true;
  users.users.paul.extraGroups = ["adbusers"];

  # Android Studio
  environment.systemPackages = with pkgs; [
    android-studio
  ];
}

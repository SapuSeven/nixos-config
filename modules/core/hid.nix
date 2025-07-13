{pkgs, ...}: {
  hardware.openrazer = {
    enable = true;
    batteryNotifier = {
      enable = true;
      percentage = 15;
      frequency = 3600;
    };
  };

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    razer-cli
  ];

  users.users.paul = {
    extraGroups = ["openrazer"];
  };
}

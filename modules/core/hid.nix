{
  lib,
  pkgs,
  config,
  ...
}: {
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

  users.users = lib.genAttrs config.hostConfig.users (user: {
    extraGroups = [ "openrazer" ];
  });
}

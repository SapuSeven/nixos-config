{ pkgs, ...} : {
  hardware.openrazer.enable = true;

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    razer-cli
  ];

  users.users.paul = {
    extraGroups = [ "openrazer" ];
  };
}

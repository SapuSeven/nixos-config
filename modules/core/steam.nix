{pkgs, ...}: {
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        STEAM_FORCE_DESKTOPUI_SCALING = 1.5;
      };
    };

    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remoteplay
    dedicatedServer.openFirewall = true; # Open ports in the firewall for steam server
  };
}

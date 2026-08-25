{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraLibraries = pkgs':
        with pkgs'; [
          libGLU
          libtinfo
          qt5.qtmultimedia
        ];
      extraEnv = {
        STEAM_FORCE_DESKTOPUI_SCALING = 1.5;
      };
    };

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  boot.extraModulePackages = lib.mkIf config.hardware.facter.detected.graphics.amd.enable [
    (pkgs.callPackage ./kernel-modules/amdgpu.nix {
      kernel = config.boot.kernelPackages.kernel;
      patches = [
        ../../overlays/patches/cap_sys_nice_begone.patch
      ];
    })
  ];
}

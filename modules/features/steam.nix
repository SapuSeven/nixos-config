{
  flake.modules.nixos.steam = {pkgs, lib, config, ...}: {
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
  };

  flake.modules.homeManager.steam = {
    lib,
    config,
    ...
  }: let
    nvidiaOffloadEnabled = config.hardware.nvidia.prime.offload.enable;
  in {
    home.persistence."/nix/persist".directories = [
      ".local/share/Steam"
      ".local/share/Terraria"
      ".cache/mesa_shader_cache"
    ];

    xdg.desktopEntries = lib.mkIf nvidiaOffloadEnabled {
      steam = {
        name = "Steam";
        icon = "steam";
        exec = "nvidia-offload steam %U";
        terminal = false;
        categories = ["Network" "FileTransfer" "Game"];
        mimeType = ["x-scheme-handler/steam" "x-scheme-handler/steamlink"];
      };
    };
  };
}


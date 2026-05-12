{pkgs, ...}:
let
  patchedBwrap = pkgs.bubblewrap.overrideAttrs (o: {
    patches = (o.patches or []) ++ [
      ../../overlays/patches/steam-bwrap.patch
    ];
  });
in {
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraLibraries = pkgs':
        with pkgs'; [
          libGLU
          libtinfo
        ];
      extraEnv = {
        STEAM_FORCE_DESKTOPUI_SCALING = 1.5;
      };
      buildFHSEnv = (args: ((pkgs.buildFHSEnv.override {
        bubblewrap = patchedBwrap;
      }) (args // {
        extraBwrapArgs = (args.extraBwrapArgs or []) ++ [ "--cap-add ALL" ];
      })));
    };

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  systemd.user.tmpfiles.rules = [
    # "L!" creates a symlink, forcefully replacing any existing file or link
    # %h expands to the user's home directory
    "L! %h/.local/share/Steam/ubuntu12_32/steam-runtime/usr/libexec/steam-runtime-tools-0/srt-bwrap - - - - ${patchedBwrap}/bin/bwrap"
  ];
}

{
  lib,
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs;
    [
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      qimgv # image viewer
      mpv # video player

      killall
      brightnessctl
      python3
      #mqtt-explorer
      stm32cubemx
      #freedownloadmanager
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      azure-cli
    ];
}

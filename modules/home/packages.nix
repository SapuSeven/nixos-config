{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    qimgv # image viewer
    mpv # video player

    brightnessctl
    python3
    freecad-wayland
    #mqtt-explorer
    stm32cubemx
  ];
}

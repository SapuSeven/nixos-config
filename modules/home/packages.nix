{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    qimgv           # image viewer
    mpv             # video player

    brightnessctl
    python3
    #ondsel
    stable.freecad
    #mqtt-explorer
  ];
}

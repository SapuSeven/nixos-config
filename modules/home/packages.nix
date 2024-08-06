{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    qimgv           # image viewer
    xfce.thunar
    brightnessctl

    python3
    #ondsel
    stable.freecad
    mqtt-explorer
  ];
}

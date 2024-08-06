{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    qimgv           # image viewer

    python3
    #ondsel
    stable.freecad
    mqtt-explorer
  ];
}

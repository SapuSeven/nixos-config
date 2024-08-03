{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    qimgv           # image viewer

    python3
  ];
}

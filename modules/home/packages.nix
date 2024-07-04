{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    kicad
    teamspeak5_client

    python3
  ]);
}

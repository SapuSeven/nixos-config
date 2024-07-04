{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    teamspeak5_client

    python3
  ]);
}

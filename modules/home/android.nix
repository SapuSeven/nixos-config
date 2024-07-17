{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      android-studio
    ];

    persistence."/nix/persist/home/paul".directories = [ ".android" ];
  };
}

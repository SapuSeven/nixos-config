{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      kicad
    ];

    persistence."/nix/persist/home/paul".directories = [ ".config/kicad" ];
  };
}

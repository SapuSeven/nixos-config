{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      orca-slicer
    ];

    persistence."/nix/persist/home/paul".directories = [ ".config/OrcaSlicer" ];
  };
}

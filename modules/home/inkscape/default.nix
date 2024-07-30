{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      inkscape
    ];

    persistence."/nix/persist/home/paul".directories = [
      #".config/inkscape"
    ];

    file = let
      svg = import ./template.svg.nix;
    in {
      "${config.xdg.configHome}/inkscape/templates/Label 50x30mm.svg" = svg {
        type = "Label";
        width = 50;
        height = 30;
        unit = "mm";
      };
    };
  };
}

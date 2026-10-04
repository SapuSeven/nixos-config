{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      inkscape
    ];

    persistence."/nix/persist".directories = [
      #".config/inkscape"
    ];

    file = let
      svg = import ./template.svg.nix;
    in {
      "${config.xdg.configHome}/inkscape/templates/Label 50x30mm.svg" = svg {
        author = config.home.username;
        type = "Label";
        width = 50;
        height = 30;
        unit = "mm";
      };
    };
  };
}

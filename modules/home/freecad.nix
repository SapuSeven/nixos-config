{pkgs, ...}: {
  home = {
    packages = with pkgs; [ freecad ];

    persistence."/nix/persist".directories = [".config/FreeCAD"];
  };
}

{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      freecad
    ];

    persistence."/nix/persist/home/paul".directories = [".config/FreeCAD"];
  };
}

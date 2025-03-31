{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      freecad-wayland
    ];

    persistence."/nix/persist/home/paul".directories = [".config/FreeCAD"];
  };
}

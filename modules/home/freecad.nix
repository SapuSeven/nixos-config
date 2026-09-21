{pkgs, ...}:
let
  extraPython = pkgs.python3.withPackages (ps: [
    ps.ezdxf
    ps.tinydb
    ps.watchdog
  ]);

  freecadWithExtras = pkgs.symlinkJoin {
    name = "freecad-with-extras";
    paths = [ pkgs.freecad ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/FreeCAD \
        --prefix PYTHONPATH : ${extraPython}/${extraPython.sitePackages}
    '';
  };
in
{
  home = {
    packages = [ freecadWithExtras ];

    persistence."/nix/persist".directories = [
      ".config/FreeCAD"
      ".local/share/FreeCAD"
    ];
  };
}

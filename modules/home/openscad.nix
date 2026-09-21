{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (openscad.withPackages (ps: [
        ps.bosl2
      ]))
    ];

    persistence."/nix/persist".directories = [".config/OpenSCAD"];
  };
}

{pkgs, ...}: let
  # FreeCAD tends to be unavailable in the build cache. The below specified commit is known to have been built by cache.nixos.org
  freecadPkg = (import (builtins.fetchTarball {
     url = "https://github.com/nixos/nixpkgs/archive/c3590535fb85011b75ca0fab81ada53191a09787.tar.gz";
     sha256 = "1qlz0ra3ga1ahkgf846k619a1m209xsm1clmglrv8qd5qvfjcnwp";
   }) {
     inherit (pkgs) system;
   }).freecad;
in {
  home = {
    packages = [ freecadPkg ];

    persistence."/nix/persist".directories = [".config/FreeCAD"];
  };
}

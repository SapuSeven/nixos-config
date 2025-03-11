# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # Games
  ftb-app = pkgs.callPackage ./ftb-app {};

  # Tools
  ondsel = pkgs.callPackage ./freecad/ondsel.nix {
    requests = pkgs.python311Packages.requests;
    freecad = pkgs.stable.freecad;
  };
  freedownloadmanager = pkgs.callPackage ./freedownloadmanager/fdm.nix {};
}

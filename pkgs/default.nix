# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  ftb-app = pkgs.callPackage ./ftb-app { };
}

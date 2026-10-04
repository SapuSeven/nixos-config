{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.system}";
  in {
    programs.niri = {
      enable = true;
      package = selfpkgs.niri;
    };
  };
}

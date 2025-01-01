{pkgs, ...}: {
  home = {
    packages = with pkgs.stable; [
      orca-slicer
    ];

    persistence."/nix/persist/home/paul".directories = [".config/OrcaSlicer"];
  };
}

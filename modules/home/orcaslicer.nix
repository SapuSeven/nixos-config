{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      orca-slicer
    ];

    persistence."/nix/persist".directories = [".config/OrcaSlicer"];
  };
}

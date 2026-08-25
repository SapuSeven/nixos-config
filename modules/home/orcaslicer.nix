{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (orca-slicer.override {
        # https://github.com/NixOS/nixpkgs/pull/531346
        # Will no longer be required once OrcaSlicer is updated to 2.4.0: https://github.com/NixOS/nixpkgs/pull/534163
        glew = glew.override {
          enableEGL = false;
        };
      })
    ];

    persistence."/nix/persist".directories = [".config/OrcaSlicer"];
  };
}

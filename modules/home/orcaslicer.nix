{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      (orca-slicer.override {
        # https://github.com/NixOS/nixpkgs/pull/531346
        glew = (glew.override {
            enableEGL = false;
        });
      })
    ];

    persistence."/nix/persist".directories = [".config/OrcaSlicer"];
  };
}

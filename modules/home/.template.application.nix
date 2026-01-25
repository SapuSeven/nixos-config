{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      FIXME
    ];

    persistence."/nix/persist".directories = [
      ".config/FIXME"
    ];
  };
}

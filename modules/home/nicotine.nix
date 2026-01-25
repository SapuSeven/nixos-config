{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      nicotine-plus
    ];

    persistence."/nix/persist".directories = [
      ".config/nicotine"
    ];
  };
}

{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      nicotine-plus
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".config/nicotine"
    ];
  };
}

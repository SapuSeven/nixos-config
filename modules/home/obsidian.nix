{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      obsidian
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".config/obsidian"
    ];
  };
}

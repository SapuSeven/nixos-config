{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      obsidian
    ];

    persistence."/nix/persist".directories = [
      ".config/obsidian"
    ];
  };
}

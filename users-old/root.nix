{...}: {
  imports = [
    ../modules/home/git.nix # include only Git module for nixos-rebuild to work properly as root
  ];

  home.stateVersion = "23.05";
}

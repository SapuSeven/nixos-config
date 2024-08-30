{...}: {
  home.persistence."/nix/persist/home/paul".directories = [
    #".steam"
    ".local/share/Steam"
  ];
}

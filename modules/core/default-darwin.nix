{...}: {
  # TODO quick fix for bawag macbook
  networking.hostName = "paul-bawag";

  imports = [
    ./homebrew.nix # macos apps
  ];
}

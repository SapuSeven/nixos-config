{
  lib,
  host,
  ...
}: {
  imports = [
    ./persistence.nix
    ./starship.nix
    ./zsh.nix
  ];
}

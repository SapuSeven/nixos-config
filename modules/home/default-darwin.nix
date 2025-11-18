{
  lib,
  host,
  ...
}: {
  imports = [
    ./persistence.nix
    ./development/common.nix
    ./starship.nix
    ./zsh.nix
  ];
}

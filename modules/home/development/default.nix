{
  lib,
  host,
  ...
}: {
  imports =
    [
      ./direnv.nix # automatic .envrc setup
      ./java.nix # java
      ./nvim # text editor
    ]
    ++ lib.optionals (host.name != "macbook") [
      ./android.nix # android
      ./jetbrains.nix # java/rust
    ];
}

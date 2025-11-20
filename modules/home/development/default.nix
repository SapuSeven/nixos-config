{
  lib,
  host,
  ...
}: {
  imports =
    [
      ./common.nix # non-language-specific
      ./java.nix # java
      ./nvim.nix # text editor
    ]
    ++ lib.optionals (host.name != "macbook") [
      ./android.nix # android
      ./jetbrains.nix # java/rust
    ];
}

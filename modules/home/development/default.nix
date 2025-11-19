{lib, host, ...}: {
  imports = [
    ./common.nix # non-language-specific
    ./nvim.nix # text editor
  ] ++ lib.optionals (host.name != "macbook") [
    ./android.nix # android
    ./jetbrains.nix # java/rust
  ];
}

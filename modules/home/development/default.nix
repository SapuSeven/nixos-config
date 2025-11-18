{...}: {
  imports = [
    ./android.nix # android
    ./common.nix # non-language-specific
    ./jetbrains.nix # java/rust
    ./nvim.nix # text editor
  ];
}

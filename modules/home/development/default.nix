{...}: {
  imports = [
    (import ./android.nix) # android
    (import ./common.nix) # non-language-specific
    (import ./jetbrains.nix) # java/rust
  ];
}

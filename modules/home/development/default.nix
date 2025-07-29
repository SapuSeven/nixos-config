{...}: {
  imports = [
    (import ./android.nix) # android
    (import ./jetbrains.nix) # java/rust
  ];
}

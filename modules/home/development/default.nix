{...}: {
  imports =
    [(import ./android.nix)] # android
    ++ [(import ./intellij.nix)]; # java
}

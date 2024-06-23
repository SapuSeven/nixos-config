{ ... }:

{
  imports =
    [
      ./configuration.nix
      ./hardware-configuration.desktop.nix
      ../modules/core
    ];
}

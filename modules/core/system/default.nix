{...}: {
  imports =
    [(import ./boot.nix)] # bootloader
    ++ [(import ./graphics.nix)] # graphics
    ++ [(import ./network.nix)] # network
    ++ [(import ./time.nix)] # time
    ++ [(import ./users.nix)] # users
    ++ [(import ./fonts.nix)] # fonts
    ++ [(import ./locale.nix)] # locale
    ++ [(import ./security.nix)] # security
    ++ [(import ./udev.nix)]; # udev rules
}

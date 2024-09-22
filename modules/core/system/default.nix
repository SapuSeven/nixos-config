{
  lib,
  host,
  ...
}: {
  imports =
    [(import ./boot.nix)] # bootloader
    ++ [(import ./network.nix)] # network
    ++ [(import ./time.nix)] # time
    ++ [(import ./users.nix)] # users
    ++ [(import ./fonts.nix)] # fonts
    ++ [(import ./locale.nix)] # locale
    ++ [(import ./security.nix)] # security
    ++ [(import ./udev.nix)] # udev rules
    ++ lib.optionals (host == "desktop") [
      (import ./graphics/amd.nix)
    ]
    ++ lib.optionals (host == "laptop") [
      (import ./graphics/amd.nix)
      (import ./graphics/nvidia.nix)
    ];
}

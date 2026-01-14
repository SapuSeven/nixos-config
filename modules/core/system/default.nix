{
  lib,
  host,
  ...
}: let
  isLinux = lib.strings.hasInfix "linux" host.system;
in {
  imports =
    [
      ./security.nix # security
    ]
    ++ lib.optionals isLinux [
      ./boot.nix # bootloader
      ./network.nix # network
      ./time.nix # time
      ./users.nix # users
      ./fonts.nix # fonts
      ./locale.nix # locale
      ./power.nix # power and sleep settings
      ./udev.nix # udev rules
    ]
    ++ lib.optionals (host.name == "desktop") [
      ./graphics/amd.nix
    ]
    ++ lib.optionals (host.name == "laptop") [
      ./graphics/amd.nix
      ./graphics/nvidia.nix
    ];
}

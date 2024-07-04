{ ... }:
{
  imports =
       [(import ./android.nix)]    # android development
    ++ [(import ./bluetooth.nix)]  # bluetooth
    ++ [(import ./syncthing.nix)]  # file sync (global service)
    ++ [(import ./udev.nix)]       # udev rules
    ++ [(import ./wireguard.nix)]; # vpn client
}

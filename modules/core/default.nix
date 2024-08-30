{ lib, host, ... }:
{
  imports =
       [(import ./adb.nix)]        # android development
    ++ [(import ./bluetooth.nix)]  # bluetooth
    ++ [(import ./cups)]           # printing
    ++ [(import ./dlna.nix)]       # media sharing
    ++ [(import ./files.nix)]      # file management
    ++ [(import ./graphics.nix)]   # graphics configuration
    ++ [(import ./restic.nix)]     # system backup
    ++ [(import ./samba.nix)]      # file shares
    ++ [(import ./syncthing.nix)]  # file sync (global service)
    ++ [(import ./udev.nix)]       # udev rules
    ++ [(import ./wayland.nix)]    # de+wm
    ++ [(import ./wireguard.nix)]  # vpn client

    ++ lib.optionals (host=="desktop") [
      (import ./steam.nix)
    ];
}

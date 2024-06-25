{ ... }:
{
  imports =
       [(import ./bluetooth.nix)]  # bluetooth
    ++ [(import ./syncthing.nix)]  # file sync
    ++ [(import ./wireguard.nix)]; # vpn client
}

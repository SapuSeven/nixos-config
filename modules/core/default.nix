{ ... }:
{
  imports =
       [(import ./bluetooth.nix)]  # bluetooth
    ++ [(import ./syncthing.nix)]  # file sync (global service)
    ++ [(import ./wireguard.nix)]; # vpn client
}

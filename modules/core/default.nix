{
  lib,
  host,
  ...
}: {
  imports =
    [(import ./adb.nix)] # android development
    ++ [(import ./agenix.nix)] # secrets management
    ++ [(import ./audio.nix)] # audio devices
    ++ [(import ./bluetooth.nix)] # bluetooth
    ++ [(import ./cups)] # printing
    ++ [(import ./dlna.nix)] # media sharing
    ++ [(import ./dm.nix)] # display manager
    ++ [(import ./files.nix)] # file management
    ++ [(import ./hid.nix)] # hid compatibility
    ++ [(import ./httptoolkit.nix)] # http sniffer
    ++ [(import ./packages.nix)] # misc packages
    ++ [(import ./restic.nix)] # system backup
    ++ [(import ./samba.nix)] # file shares
    ++ [(import ./ssh.nix)] # ssh
    ++ [(import ./system)] # system settings
    ++ [(import ./wayland.nix)] # de+wm
    ++ [(import ./wireguard.nix)] # vpn client
    ++ [(import ./steam.nix)]
    ++ lib.optionals (host == "desktop") [
    ]
    ++ lib.optionals (host == "laptop") [
    ];
}

{...}: {
  imports = [
    ./adb.nix # android development
    ./agenix.nix # secrets management
    ./audio.nix # audio devices
    ./bluetooth.nix # bluetooth
    ./cups # printing
    ./dlna.nix # media sharing
    ./dm.nix # display manager
    ./files.nix # file management
    ./hid.nix # hid compatibility
    ./httptoolkit.nix # http sniffer
    ./nixos.nix # nixos-related config
    ./packages.nix # misc packages
    ./restic.nix # system backup
    ./samba.nix # file shares
    ./ssh.nix # ssh
    ./system # system settings
    ./wayland.nix # de+wm
    ./wireguard.nix # vpn client
    ./steam.nix
    ./yubikey.nix
  ];
}

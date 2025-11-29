{
  lib,
  host,
  ...
}: let
  isLinux = lib.strings.hasInfix "linux" host.system;
  isDarwin = lib.strings.hasInfix "darwin" host.system;
in {
  imports =
    [
      ./wireguard.nix # vpn client
      ./persistence.nix # impermanence support module
    ]
    ++ lib.optionals isLinux [
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
      ./steam.nix # game store
      ./system # system settings
      ./wayland.nix # de+wm
      ./yubikey.nix # security key
    ]
    ++ lib.optionals isDarwin [
      ./homebrew.nix # macos apps
    ];
}

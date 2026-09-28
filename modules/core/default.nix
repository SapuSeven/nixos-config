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
      ./system # system settings
    ]
    ++ lib.optionals isLinux [
      ./adb.nix # android development
      ./agenix.nix # secrets management
      ./audio.nix # audio devices
      ./bluetooth.nix # bluetooth
      ./compatibility.nix # legacy application compatibility
      ./cups # printing
      ./dlna.nix # media sharing
      ./emulation.nix # emulation
      ./esphome.nix # esphome build server
      ./files.nix # file management
      ./greetd.nix # greeter
      ./hid.nix # hid compatibility
      ./httptoolkit.nix # http sniffer
      ./hyprland.nix # wm
      ./legacy-linux.nix # legacy linux config
      ./niri.nix # wm
      ./nixos.nix # nixos-related config
      ./packages.nix # misc packages
      ./restic.nix # system backup
      ./samba.nix # file shares
      ./ssh.nix # ssh
      ./steam.nix # game store
      ./wayland.nix # de
      ./yubikey.nix # security key
    ]
    ++ lib.optionals isDarwin [
      ./homebrew.nix # macos apps
    ];
}

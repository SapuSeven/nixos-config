{
  lib,
  host,
  ...
}: let
  isLinux = lib.strings.hasInfix "linux" host.system;
in {
  imports =
    [
      ./persistence.nix
      ./development # development environments
      ./git.nix # vcs
      ./lazy-apps.nix # lazy apps
      ./packages.nix # other packages
      ./starship.nix # shell prompt
      ./syncthing.nix # file sync
      ./vscode.nix # code editor
      ./zsh.nix # shell
    ]
    ++ lib.optionals isLinux [
      ./avizo.nix # osd
      ./editor.nix # text editor
      ./files.nix # file management
      #./firefox.nix # browser, replaced by zen
      ./freecad.nix # 3d modeling
      ./games # games
      ./httptoolkit.nix # http sniffer
      ./hypr # hypr*
      ./inkscape # svg drawings
      ./keepassxc.nix # password manager
      ./keyring.nix # gnome keyring
      ./kitty.nix # terminal
      ./kicad.nix # kicad eda
      ./libreoffice.nix # office suite
      ./mako.nix # notifications
      #./nicotine.nix # soulseek
      ./obsidian.nix # notes
      ./orcaslicer.nix # slicer
      ./teamspeak.nix # teamspeak
      ./theme.nix # theme
      ./deluge.nix # torrent client
      ./waybar # status bar
      ./wofi.nix # launcher
      ./wlogout # logout menu
      ./wluma.nix # backlight brightness control
      ./yubikey.nix # yubikey
      ./zen.nix # browser
    ]
    ++ lib.optionals (host.name == "laptop") [
      ./batsignal.nix # battery level monitoring
    ];
}

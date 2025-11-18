{
  lib,
  host,
  ...
}: {
  imports = [
    ./persistence.nix
    ./development/common.nix # development environments
    ./git.nix # vcs
    ./nvim.nix # text editor
    ./packages.nix # other packages
    ./starship.nix # shell prompt
    ./zsh.nix # shell
  ] ++ lib.optionals (host.name != "macbook") [
    ./avizo.nix # osd
    ./development # development environments
    ./editor.nix # text editor
    ./files.nix # file management
    ./firefox.nix # browser
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
    ./syncthing.nix # file sync
    ./teamspeak.nix # teamspeak
    ./theme.nix # theme
    ./deluge.nix # torrent client
    ./vscode.nix # code editor
    ./waybar # status bar
    ./wofi.nix # launcher
    ./wlogout # logout menu
    ./wluma.nix # backlight brightness control
    ./yubikey.nix # yubikey
  ] ++ lib.optionals (host.name == "laptop") [
    (import ./batsignal.nix) # battery level monitoring
  ];
}

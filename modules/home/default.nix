{
  lib,
  host,
  ...
}: {
  imports =
    [(import ./persistence.nix)]
    ++ [(import ./avizo.nix)] # osd
    ++ [(import ./development)] # development environments
    ++ [(import ./editor.nix)] # text editor
    ++ [(import ./files.nix)] # file management
    ++ [(import ./firefox.nix)] # browser
    ++ [(import ./freecad.nix)] # 3d modeling
    ++ [(import ./games)] # games
    ++ [(import ./git.nix)] # vcs
    ++ [(import ./httptoolkit.nix)] # http sniffer
    ++ [(import ./hypr)] # hypr*
    ++ [(import ./inkscape)] # svg drawings
    ++ [(import ./keepassxc.nix)] # password manager
    ++ [(import ./keyring.nix)] # gnome keyring
    ++ [(import ./kitty.nix)] # terminal
    ++ [(import ./kicad.nix)] # kicad eda
    ++ [(import ./libreoffice.nix)] # office suite
    ++ [(import ./mako.nix)] # notifications
    #++ [(import ./nicotine.nix)] # soulseek
    ++ [(import ./obsidian.nix)] # notes
    ++ [(import ./orcaslicer.nix)] # slicer
    ++ [(import ./packages.nix)] # other packages
    ++ [(import ./starship.nix)] # shell prompt
    ++ [(import ./syncthing.nix)] # file sync
    ++ [(import ./teamspeak.nix)] # teamspeak
    ++ [(import ./theme.nix)] # theme
    ++ [(import ./deluge.nix)] # torrent client
    ++ [(import ./vscode.nix)] # code editor
    ++ [(import ./waybar)] # status bar
    ++ [(import ./wofi.nix)] # launcher
    ++ [(import ./wlogout)] # logout menu
    ++ [(import ./wluma.nix)] # backlight brightness control
    ++ [(import ./yubikey.nix)] # yubikey
    ++ [(import ./zsh.nix)] # shell
    ++ lib.optionals (host == "laptop") [
      (import ./batsignal.nix) # battery level monitoring
    ];
}

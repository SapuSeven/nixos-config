{ ... }:
{
  imports =
       [(import ./android.nix)]     # android development
    ++ [(import ./firefox.nix)]     # browser
    ++ [(import ./games)]           # games
    ++ [(import ./git.nix)]         # vcs
    ++ [(import ./hypr)]            # hypr*
    ++ [(import ./keepassxc.nix)]   # password manager
    ++ [(import ./kitty.nix)]       # terminal
    ++ [(import ./kicad.nix)]       # kicad eda
    ++ [(import ./libreoffice.nix)] # office suite
    ++ [(import ./orcaslicer.nix)]  # slicer
    ++ [(import ./packages.nix)]    # other packages
    ++ [(import ./starship.nix)]    # shell prompt
    ++ [(import ./teamspeak.nix)]   # teamspeak
    ++ [(import ./theme.nix)]       # theme
    ++ [(import ./vscode.nix)]      # code editor
    ++ [(import ./waybar)]          # status bar
    ++ [(import ./wofi.nix)]        # launcher
    ++ [(import ./wluma.nix)]       # backlight brightness control
    ++ [(import ./zsh.nix)];        # shell
}

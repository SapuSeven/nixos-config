{ ... }:
{
  imports =
       [(import ./firefox.nix)]  # browser
    ++ [(import ./git.nix)]      # vcs
    ++ [(import ./hypr)]         # hypr*
    ++ [(import ./kitty.nix)]    # terminal
    ++ [(import ./packages.nix)] # other packages
    ++ [(import ./starship.nix)] # shell prompt
    ++ [(import ./theme.nix)]    # theme
    ++ [(import ./waybar)]       # status bar
    ++ [(import ./wofi.nix)]     # launcher
    ++ [(import ./wluma.nix)]    # backlight brightness control
    ++ [(import ./zsh.nix)];     # shell
}

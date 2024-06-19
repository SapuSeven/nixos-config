{ ... }:
{
  imports =
       [(import ./firefox.nix)]  # browser
    ++ [(import ./hypr)]         # hypr-stuff
    ++ [(import ./kitty.nix)]    # terminal
    ++ [(import ./packages.nix)] # other packages
    ++ [(import ./starship.nix)] # shell prompt
    ++ [(import ./theme.nix)]    # theme
    ++ [(import ./waybar)]       # status bar
    ++ [(import ./wofi.nix)]     # launcher
    ++ [(import ./zsh.nix)];     # shell
}

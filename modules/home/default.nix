{ ... }:
{
  imports =
       [(import ./firefox.nix)]  # browser
    ++ [(import ./packages.nix)] # other packages
    ++ [(import ./starship.nix)] # shell prompt
    ++ [(import ./waybar)]       # status bar
    ++ [(import ./wofi.nix)]     # launcher
    ++ [(import ./zsh.nix)];     # shell
}

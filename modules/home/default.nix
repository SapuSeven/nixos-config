{ ... }:
{
  imports =
       [(import ./firefox.nix)]  # browser
    ++ [(import ./waybar)]       # status bar
    ++ [(import ./wofi.nix)];    # launcher
}

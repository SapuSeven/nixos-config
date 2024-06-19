{ ... }:
{
  imports =
       [(import ./waybar)]     # status bar
    ++ [(import ./wofi.nix)];  # launcher
}

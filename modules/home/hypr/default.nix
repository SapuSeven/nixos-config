{ ... }: 
{
  imports =  [ (import ./hyprland.nix) ]
          ++ [ (import ./hyprpaper.nix) ]
          ++ [ (import ./hyprlock.nix) ];
}

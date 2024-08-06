{ ... }:
{
  imports =  [ (import ./wlogout.nix) ]
          ++ [ (import ./layout.nix) ]
          ++ [ (import ./style.nix) ];
}

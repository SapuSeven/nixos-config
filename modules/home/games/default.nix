{ ... }:
{
  imports =
       [(import ./ftb-app.nix)]
    ++ [(import ./minecraft.nix)]
  ;
}

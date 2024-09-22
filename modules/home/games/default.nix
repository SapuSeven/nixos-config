{
  host,
  lib,
  ...
}: {
  imports =
    lib.optionals (host == "desktop") [
      (import ./ftb-app.nix)
      (import ./minecraft.nix)
    ]
    ++ [
      (import ./steam.nix)
    ];
}

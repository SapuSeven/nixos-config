{
  host,
  lib,
  ...
}: {
  imports =
    lib.optionals (host == "desktop") [
      (import ./ftb-app.nix)
    ]
    ++ [
      (import ./steam.nix)
      (import ./minecraft.nix)
    ];
}

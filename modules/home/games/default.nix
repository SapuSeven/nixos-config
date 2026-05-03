{
  host,
  lib,
  ...
}: {
  imports =
    [
      ./standalone.nix
      ./steam.nix
      ./minecraft.nix
    ]
    ++ lib.optionals (host == "desktop") [
      ./ftb-app.nix
    ];
}

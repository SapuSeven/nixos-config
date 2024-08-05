{ host, lib, ... }:
{
  imports = lib.optionals (host=="desktop") [
    (import ./ftb-app.nix)
  ];
}

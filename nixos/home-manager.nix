{
  inputs,
  outputs,
  system,
  host,
  pkgs,
  lib,
  ...
}: {
  # Home manager configuration
  home-manager = {
    extraSpecialArgs = {inherit system inputs outputs host;};
    backupFileExtension = "backup";
    users.${host.user} = {
      imports =
        [../home-manager/${host.user}.nix] ++
        lib.optionals pkgs.stdenv.isLinux [ ../modules/home ] ++
        lib.optionals pkgs.stdenv.isDarwin [ ../modules/home/default-darwin.nix ];
    };
  } // (lib.optionalAttrs pkgs.stdenv.isLinux {
    users.root = {
      imports = [
        ../home-manager/root.nix
        ../modules/home/git.nix # include only Git module for doas nixos-rebuild to work properly
      ];
    };
  });
}

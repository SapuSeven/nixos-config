{
  inputs,
  outputs,
  system,
  host,
  pkgs,
  user,
  lib,
  ...
}: {
  # Home manager configuration
  home-manager = {
    extraSpecialArgs = {inherit system inputs outputs host;};
    backupFileExtension = "backup";
    users.${user} = {
      imports =
        [../home-manager/${user}.nix] ++
        lib.optionals pkgs.stdenv.isLinux [ ../modules/home ];
    };
    users.root = lib.optionalAttrs pkgs.stdenv.isLinux {
      imports = [
        ../home-manager/root.nix
        ../modules/home/git.nix # include only Git module for doas nixos-rebuild to work properly
      ];
    };
  };
}

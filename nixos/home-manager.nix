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
    users = {
      ${host.user} = {
        imports = [
          ../home-manager/${host.user}.nix
          ../modules/home
        ];
      };
    } // lib.optionalAttrs pkgs.stdenv.isLinux {
      root = {
        imports = [
          ../home-manager/root.nix
          ../modules/home/git.nix # include only Git module for doas nixos-rebuild to work properly
        ];
      };
    };
  };
}

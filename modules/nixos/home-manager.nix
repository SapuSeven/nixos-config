{
  lib,
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  # Home manager configuration
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
      host = config.hostConfig;
    };
    backupFileExtension = "backup";

    # Use global nixpkgs with config options (like allow-unfree)
    useGlobalPkgs = true;
    useUserPackages = true;

    users =
      lib.genAttrs config.hostConfig.users (user: {
        imports = [
          ../../users/${user}.nix
        ];
      })
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        root = {
          imports = [
            ../../users/root.nix
          ];
        };
      };
  };
}

{
  self,
  lib,
  ...
}:
{
  flake.modules.nixos.system-default = {
    imports =
      with self.modules.nixos;
      [
        system-base
        home-manager
        secrets
      ];

    options.host = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Host configuration name";
      };
    };
  };

  flake.modules.darwin.system-default = {
    imports =
      with self.modules.darwin;
      [
        system-base
        #determinate
        home-manager
        #homebrew
        #secrets
      ];

    options.host = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Host configuration name";
      };
    };
  };

  flake.modules.homeManager.system-default = {
    imports =
      with self.modules.homeManager;
      [
        system-base
        #secrets
      ];
  };
}

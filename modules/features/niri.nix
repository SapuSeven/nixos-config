{ self, inputs, ...}: {
  flake.wrappersModules.niri = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.terminal = lib.mkOption {
      type = lib.types.str;
      default = "kitty";
    };
    config = {
      settings = let
        # startNoctaliaExe = lib.getExe self.packages.${config.pkgs.stdenv.hostPlatform.system}.start-noctalia-shell;
        noctaliaExe = lib.getExe self.packages.${config.pkgs.stdenv.hostPlatform.system}.noctalia-shell;
      in {
        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 4;

        binds = {
          "Mod+Return".spawn = config.terminal;

          "Mod+Q".close-window = null;
        };
      };
    };
  };

  perSystem = { pkgs, lib, ... }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [self.wrappersModules.niri];
   };
  };
}

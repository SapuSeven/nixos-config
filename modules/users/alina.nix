{self, lib, ...}: let
  username = "alina";
in {
  flake.homeConfigurations = self.lib.ixmkHomeManager "x86_64-linux" "${username}";

  flake.modules = lib.mkMerge [
    (self.factory.user "${username}" true)
    {
      nixos.${username} = {
       users.users.${username} = {
          group = "audio";
        };
      };

      darwin.${username} = {
      };

      homeManager.${username} = { pkgs, ... }: {
        imports = with self.modules.homeManager; [
          system-desktop
        ];
      };
    }
  ];
}

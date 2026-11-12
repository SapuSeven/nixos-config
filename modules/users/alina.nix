{self, lib, ...}: let
  username = "alina";
  usersecret = "users-${username}";
in {
  flake.homeConfigurations = self.lib.ixmkHomeManager "x86_64-linux" "${username}";

  flake.modules = lib.mkMerge [
    (self.factory.user "${username}" true)
    {
      nixos.${username} = {config, ...}: {
        age.secrets.${usersecret}.file = ../../secrets/${usersecret}.age;
        
        users.users.${username} = {
          hashedPasswordFile = config.age.secrets.${usersecret}.path;
        };
      };

      darwin.${username} = {
      };

      homeManager.${username} = { pkgs, ... }: {
        imports = with self.modules.homeManager; [
          system-graphical
        ];
      };
    }
  ];
}

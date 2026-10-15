{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.host-desktop = {config, ...}: {
    imports =
      with inputs.self.modules.nixos;
      with inputs.self.factory;
      [
        alina
#        (mount-cifs-nixos {
#          host = "home-server.lan";
#          resource = "home";
#          destination = "/home/users/bob/homeserver";
#          credentialspath = "${config.age.secrets."homeserver-cred".path}";
#          UID = "bob";
#          GID = "users";
#        })
      ];

#    age.secrets."homeserver-cred" = {
#      file = "${self.inputs.secrets}/homeserver-cred.age";
#    };

    # ...

    home-manager.users.alina = {};
  };
}

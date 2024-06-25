{ ... }:
{
  # Syncthing will be running on localhost:8384
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "paul";
    dataDir = "/home/paul/Files";
    configDir = "/home/paul/.config/syncthing";
#    settings = {
#      defaults = {
#        folder = {
#          path = "~/Files";
#        };
#      };
#    };
  };

  environment.persistence."/nix/persist".users.paul.directories = [
    ".config/syncthing"
  ];
}

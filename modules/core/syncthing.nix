{ ... }:
{
  # Not clean... but it's easier to define the global config here
  # until https://github.com/nix-community/home-manager/issues/4049 is resolved

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
}

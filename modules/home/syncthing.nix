{host, ...}: {
  home.persistence."/nix/persist/home/paul".directories = [
    "Sync"
    ".local/state/syncthing"
  ];

  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      options = {
        urAccepted = -1; # no usage data sharing
      };
      "defaults/folder" = {
        path = "~/Sync";
      };
    };
  };
}

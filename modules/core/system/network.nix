{config, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  environment.persistence."/nix/persist/system".directories = [
    "/etc/NetworkManager/system-connections"
  ];
}

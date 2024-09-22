{config, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";

    firewall = {
      allowedTCPPorts = [
        18266 # ArduinoOTA host-port
      ];
    };
  };

  environment.persistence."/nix/persist/system".directories = [
    "/etc/NetworkManager/system-connections"
  ];
}

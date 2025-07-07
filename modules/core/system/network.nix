{config, host, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = "nixos-${host}";

    firewall = {
      allowedTCPPorts = [
        18266 # ArduinoOTA host-port
        22000 # Syncthing (TCP based sync protocol traffic)
      ];
      allowedUDPPorts = [
        22000 # Syncthing (QUIC based sync protocol traffic)
        21027 # Syncthing discovery
      ];
    };
  };

  environment.persistence."/nix/persist/system".directories = [
    "/etc/NetworkManager/system-connections"
  ];
}

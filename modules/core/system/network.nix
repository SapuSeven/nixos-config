{...}: {
  networking = {
    hostName = "nixos";
    # wireless.enable = true;  # Enables wireless support via wpa_supplican>

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;

    firewall = {
      allowedTCPPorts = [
        18266 # ArduinoOTA host-port
      ];
    };
  };
}

{ pkgs, ... }:
{
  systemd.services.esphome = {
    description = "ESPHome Device Builder";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.esphome-device-builder}/bin/esphome-device-builder \
          --remote-build-only /var/lib/esphome
      '';
      StateDirectory = "esphome";
      WorkingDirectory = "/var/lib/esphome";
      Restart = "on-failure";
    };
    
    path = [ pkgs.bash pkgs.coreutils ];
  };

  networking.firewall.allowedTCPPorts = [ 6055 ]; # remote build server port

  persistence.directories = [
    "/var/lib/esphome"
  ];
}


{ lib, ... }:
{
  networking.wg-quick.interfaces = { #if builtins.pathExists "/root/.wg" then {
    wg0 = {
      autostart = false;
      address = [ "192.168.2.104/24" ];
      dns = [ "192.168.2.1" ];

      privateKeyFile = "/root/.wg/lan.privatekey";

      peers = [
        {
          publicKey = "wBlBcI5vdH24Y5mgnxgr3/eUStt5lBvloiDyhhot/EY=";
          presharedKeyFile = "/root/.wg/lan.presharedkey";
          allowedIPs = [ "192.168.0.0/24" "192.168.1.0/24" "192.168.2.0/24" ];
          endpoint = "home.sapuseven.com:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  }; #else builtins.trace "Wireguard is disabled because /root/.wg dir with private keys is missing." {};

  #systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [];

  environment.persistence."/nix/persist/system".directories = [
    "/root/.wg"
  ];
}

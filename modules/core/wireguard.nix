{ ... }:
{
  networking.wg-quick.interfaces = {
    wg0 = {
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
  };

  environment.persistence."/nix/persist/system".directories = [
    "/root/.wg"
  ];
}

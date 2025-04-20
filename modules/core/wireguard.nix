{
  lib,
  host,
  ...
}: {
  networking.wg-quick.interfaces = {
    #if builtins.pathExists "/root/.wg" then {
    wg0 = {
      autostart = false;

      dns = ["10.0.200.1"];
      address = [
        "10.0.200.${
          if host == "laptop"
          then "103"
          else "104"
        }/24"
      ];

      privateKeyFile = "/root/.wg/lan.privatekey";

      peers = [
        {
          publicKey = "wBlBcI5vdH24Y5mgnxgr3/eUStt5lBvloiDyhhot/EY=";
          presharedKeyFile = "/root/.wg/lan.presharedkey";
          allowedIPs = ["10.0.0.0/16"];
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

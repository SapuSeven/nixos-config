{
  host,
  pkgs,
  ...
}: let
  wireguardKeyDir =
    if pkgs.stdenv.isDarwin
    then "/var/root/.wg"
    else "/root/.wg";
in {
  networking.wg-quick.interfaces = {
    #if builtins.pathExists "/root/.wg" then {
    wg0 = {
      autostart = false;

      dns = ["1.1.1.1"]; #["10.0.200.1"];
      mtu = 1280;

      address = [
        "10.0.200.${{
          "laptop" = "103";
          "desktop" = "104";
          "macbook" = "105";
        }."${host.name}"}/24"
      ];

      privateKeyFile = "${wireguardKeyDir}/lan.privatekey";

      peers = [
        {
          publicKey = "wBlBcI5vdH24Y5mgnxgr3/eUStt5lBvloiDyhhot/EY=";
          presharedKeyFile = "${wireguardKeyDir}/lan.presharedkey";
          allowedIPs = ["10.0.0.0/16"];
          endpoint = "home.sapuseven.com:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  }; #else builtins.trace "Wireguard is disabled because /root/.wg dir with private keys is missing." {};

  #systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [];

  persistence.directories = [
    "/root/.wg"
  ];
}

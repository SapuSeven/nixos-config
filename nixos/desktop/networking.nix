{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
  };
  systemd.network.networks."50-en" = {
    name = "en*";
    DHCP = "ipv4";
    networkConfig = {
      IPv6PrivacyExtensions = "kernel";
      #MulticastDNS = true;
    };
  };

  services.avahi.enable = true;

  # Used to ensure ZFS pools aren't imported accidentally on a wrong machine
  networking.hostId = "a42774ed";
}


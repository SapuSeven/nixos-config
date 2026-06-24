{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;

    resolvconf.dnsSingleRequest = true;

    # Used to ensure ZFS pools aren't imported accidentally on a wrong machine
    hostId = "a42774ed";
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
}


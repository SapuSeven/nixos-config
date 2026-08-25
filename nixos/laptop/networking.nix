{lib, ...}: {
  networking = {
    useDHCP = lib.mkDefault true;
  };

  # Used to ensure ZFS pools aren't imported accidentally on a wrong machine
  networking.hostId = "23fba53a";
}

{host, ...}: {
  boot.loader = {
    #boot.loader.systemd-boot.enable = true;
    #boot.loader.systemd-boot.consoleMode = "max";
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      fontSize =
        if (host == "desktop")
        then 32
        else 16;
    };
  };

  boot.supportedFilesystems = ["ntfs" "zfs"];
}

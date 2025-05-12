{pkgs, ...}: {
  boot = {
    loader = {
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
      };
    };

    supportedFilesystems = ["ntfs" "zfs"];

    # Allows hibernation with zfs and swapfile (can potentially lead to data corruption)
    zfs = {
      forceImportRoot = false;
      allowHibernation = true;
    };
  };
}

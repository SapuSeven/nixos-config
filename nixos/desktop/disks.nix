{...}: {
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=12G" "mode=755"];
  };

  fileSystems."/home/paul" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=24G" "mode=777"];
    neededForBoot = true; # https://github.com/nix-community/impermanence/issues/298
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/nix";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/42F9-5F07";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # Extra data partitions
  fileSystems."/run/media/paul/Thicc" = {
    device = "/dev/disk/by-uuid/C808BEE708BED3A2";
    fsType = "ntfs";
  };

  fileSystems."/run/media/paul/Speed" = {
    device = "/dev/disk/by-uuid/77DC81AE32D5864F";
    fsType = "ntfs";
  };

  swapDevices = [
    {
      device = "/nix/swapfile";
      size = 16 * 1024;
    }
  ];  
}

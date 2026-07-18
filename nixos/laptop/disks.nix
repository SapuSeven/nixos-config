{host, ...}: {
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=12G" "mode=755"];
  };

  fileSystems."/home/${host.user}" = {
    device = "none";
    fsType = "tmpfs";
    options = ["defaults" "size=8G" "mode=777"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D4D7-FAD6";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/78e938be-b640-470b-93f0-6afc8c7051b8";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/nix/swapfile";
      size = 16 * 1024;
    }
  ];
}

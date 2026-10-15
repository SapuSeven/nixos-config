{
  flake.modules.nixos.host-desktop = {config, lib, pkgs, ...}: {
    fileSystems = {
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = ["defaults" "size=12G" "mode=755"];
      };

      "/nix" = {
        device = "/dev/mapper/nix";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/42F9-5F07";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      # Extra data partitions
#      "/run/media/${config.hostConfig.primaryUser}/Thicc" = {
#        device = "/dev/disk/by-uuid/C808BEE708BED3A2";
#        fsType = "ntfs";
#      };

#      "/run/media/${config.hostConfig.primaryUser}/Speed" = {
#        device = "/dev/disk/by-uuid/77DC81AE32D5864F";
#        fsType = "ntfs";
#      };
#    } // lib.genAttrs
#      (map (user: "/home/${user}") config.hostConfig.users)
#      (path: {
#        device = "none";
#        fsType = "tmpfs";
#        options = [ "defaults" "size=24G" "mode=777" ];
#        neededForBoot = true;
#      });
    };

    swapDevices = [
      {
        device = "/nix/swapfile";
        size = 16 * 1024;
      }
    ];
  };
}

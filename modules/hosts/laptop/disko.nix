{inputs, ...}: {
  flake-file.inputs = {
    disko.url = "github:nix-community/disko";
  };

  flake.modules.nixos.host-laptop = {config, lib, ...}: {
    imports = [ inputs.disko.nixosModules.disko ];

    fileSystems."/nix".neededForBoot = true;

    disko.devices = {
      nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            "size=25%"
            "mode=755"
          ];
        };
      };

      disk.main = {
        device = "/dev/nvme0n1";
        type = "disk";

        content = {
          type = "gpt";

          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };

            esp = {
              name = "ESP";
              size = "1G";
              type = "EF00";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            swap = {
              size = "16G";

              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            root = {
              name = "root";
              size = "100%";

              content = {
                type = "btrfs";
                extraArgs = ["-f"];

                subvolumes = {
                  "/persistent" = {
                    mountOptions = ["subvol=persistent" "noatime"];
                    mountpoint = "/persistent";
                  };

                  "/nix" = {
                    mountOptions = ["subvol=nix" "noatime"];
                    mountpoint = "/nix";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

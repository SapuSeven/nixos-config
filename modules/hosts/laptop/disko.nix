{inputs, ...}: {
  flake-file.inputs = {
    disko.url = "github:nix-community/disko";
  };

  flake.modules.nixos.host-laptop = {config, lib, ...}: {
    imports = [ inputs.disko.nixosModules.disko ];

    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persistent".neededForBoot = true;

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
        type = "disk";
        device = "/dev/nvme0n1";

        content = {
          type = "gpt";

          partitions = {
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
              size = "100%";

              content = {
                type = "luks";
                name = "root";

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
  };
}

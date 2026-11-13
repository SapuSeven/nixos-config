{
  flake.modules.nixos.host-laptop = {lib, ...}: {
    boot = {
      initrd = {
        systemd.enable = true;
        availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
        kernelModules = [];
      };

      kernel.sysctl."kernel.sysrq" = 1;

      kernelModules = ["kvm-intel"];

      loader = {
        systemd-boot = {
          enable = true;
        };
        efi = {
          canTouchEfiVariables = true;
          #efiSysMountPoint = "/boot";
        };
      };
    };
  };
}

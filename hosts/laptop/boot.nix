{...}: {
  boot = {
    initrd = {
      systemd.enable = true;
      luks = {
        #fido2Support = false;
        devices = {
          "nix" = {
            device = "/dev/disk/by-uuid/d404465b-4b9f-405b-8497-40c8b78a976b";
            #crypttabExtraOpts = ["fido2-device=auto"];
          };
        };
      };
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "hid_generic"];
    };

    kernel.sysctl."kernel.sysrq" = 1;

    kernelModules = ["kvm-amd"];
  };
}

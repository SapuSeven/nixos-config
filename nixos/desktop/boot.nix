{...}: {
  boot = {
    initrd = {
      systemd.enable = true;
      luks = {
        fido2Support = false;
        devices = {
          "nix" = {
            device = "/dev/disk/by-uuid/fd378e80-1738-49b9-ad0c-d32f1ab67d1f";
            crypttabExtraOpts = ["fido2-device=auto"];
          };
        };
      };
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "hid_generic"];
      kernelModules = ["vfat" "nls_cp437" "nls_iso8859-1" "usbhid" "dm-thin-pool"];
    };

    kernel.sysctl."kernel.sysrq" = 1;

    kernelModules = ["kvm-amd"];
    kernelParams = ["resume_offset=19505152"];
    resumeDevice = "/dev/dm-0";
  };
}

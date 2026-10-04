{
  flake.modules.nixos.hostDesktopBoot = {lib, ...}: {
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

      loader = {
        systemd-boot = {
          enable = lib.mkForce false;
        };
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

      # Secure Boot via Lanzaboote only works with systemd-boot.
      # Since GRUB looks a lot nicer, it seems there is a much easier way of setting up secure boot.
      # First, generate new keys in /var/lib/sbctl if necessary and sign GRUB:
      #  $ doas sbctl create-keys
      #  $ doas sbctl sign -s /boot/EFI/NixOS-boot/grubx64.efi
      # Then enter the BIOS, enable Secure Boot and ensure all keys are reset/deleted. This enables setup mode.
      # Boot into NixOS again and enroll the keys:
      #  $ doas sbctl enroll-keys --microsoft
      # Reboot, and it's done. You can check the secure boot status at every point using `bootctl status`.
      # For some reason this seems to do the trick. It seems too simple, but it works somehow.

      supportedFilesystems = ["ntfs" "zfs"];

      # Allows hibernation with zfs and swapfile (can potentially lead to data corruption)
      zfs = {
        forceImportRoot = false;
        unsafeAllowHibernation = true;
      };
    };

    persistence.directories = [ "/var/lib/sbctl" ];
  };
}

{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
        #consoleMode = "max";
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
    # TODO: Automate this setup in NixOS

    supportedFilesystems = ["ntfs" "zfs"];

    # Allows hibernation with zfs and swapfile (can potentially lead to data corruption)
    zfs = {
      forceImportRoot = false;
      unsafeAllowHibernation = true;
    };
  };

  environment.persistence."/nix/persist/system".directories = [
    "/var/lib/sbctl"
  ];
}

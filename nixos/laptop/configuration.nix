{
  config,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./disks.nix
    ./networking.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.lvm.boot.thin.enable = true;

  hardware.facter = {
    reportPath = ./facter.json;
    detected.dhcp.enable = false;
  };
}

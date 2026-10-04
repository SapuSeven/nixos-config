{inputs, ...}: {
  flake.modules.nixos.hostDesktop = {config, lib, ...}: {
    imports = with inputs.self.modules.nixos; [
      hostDesktopBoot
      hostDesktopDisks
      hostDesktopNetworking

      base
      #desktop

      impermanence
    ];

    persistence.enable = true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    services.lvm.boot.thin.enable = true;

    hardware.facter = {
      reportPath = ./facter.json;
      detected.dhcp.enable = false;
    };
  };
}

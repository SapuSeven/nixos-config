{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "desktop";

  flake.modules.nixos.host-desktop = {config, lib, ...}: {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      home-manager

      impermanence
    ];

    persistence.enable = true;

    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    services.lvm.boot.thin.enable = true;

    hardware.facter = {
      reportPath = ./facter.json;
      detected.dhcp.enable = false;
    };

    host = {};
  };
}

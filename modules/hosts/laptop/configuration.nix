{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "laptop";

  flake.modules.nixos.host-laptop = {config, lib, ...}: {
    imports = with inputs.self.modules.nixos; [
      system-cli
      home-manager

      impermanence
    ];

    persistence = {
      enable = true;
      persistDir = "/persistent";
    };

    services.fwupd.enable = true;

    hardware.enableRedistributableFirmware = true;
    hardware.cpu.intel.npu.enable = true;
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    host = {};
  };
}

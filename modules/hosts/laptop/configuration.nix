{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "laptop";

  flake.modules.nixos.host-laptop = {config, lib, ...}: {
    imports = with inputs.self.modules.nixos; [
      system-graphical
      home-manager

      impermanence
    ];

    persistence.enable = true;

    host = {};
  };
}

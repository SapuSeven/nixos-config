{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.host-laptop = {config, ...}: {
    imports = [
      inputs.self.modules.nixos.alina
    ];

    home-manager.users.alina = {};
  };
}

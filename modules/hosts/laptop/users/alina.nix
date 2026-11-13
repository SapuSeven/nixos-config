{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.host-laptop = {config, ...}: {
    imports =
      with inputs.self.modules.nixos;
      with inputs.self.factory;
      [ alina ];

    home-manager.users.alina = {};
  };
}

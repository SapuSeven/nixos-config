{inputs, ...}: {
  flake-file.inputs = {
    agenix.url = "github:ryantm/agenix";
  };

  flake.modules.nixos.secrets = {
    lib,
    config,
    ...
  }: {
    imports = [ inputs.agenix.nixosModules.default ];
  };
}

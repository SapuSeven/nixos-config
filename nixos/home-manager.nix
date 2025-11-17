{
  inputs,
  outputs,
  system,
  host,
  pkgs,
  user,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Home manager configuration
  home-manager = {
    extraSpecialArgs = {inherit system inputs outputs host;};
    backupFileExtension = "backup";
    users.${user} = {
      imports = [
        ../home-manager/${user}.nix
        ../modules/home # Include all modules
      ];
    };
    users.root = {
      imports = [
        ../home-manager/root.nix
        ../modules/home/git.nix # include only Git module for doas nixos-rebuild to work properly
      ];
    };
  };
}

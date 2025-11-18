{
  pkgs,
  inputs,
  ...
}: let
  user = "paul.kratochwill";
in
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  home = {
    username = user;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };

  nix-homebrew = {
    user = user;
    enable = true;
    autoMigrate = true;
  };

  # BAWAG config
#  security.pki.certificateFiles = [
#    ./bawag-certs.pem
#  ];

}

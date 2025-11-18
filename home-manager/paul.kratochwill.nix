{
  pkgs,
  ...
}: let
  user = "paul.kratochwill";
in
{
  networking.hostName = "paul-bawag";

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

  homebrew.casks = [
  ];

  # BAWAG config
#  security.pki.certificateFiles = [
#    ./bawag-certs.pem
#  ];

}

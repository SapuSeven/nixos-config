{
  pkgs,
  ...
}: let
  user = "paul.kratochwill"
in
{
  networking.hostName = "paul-bawag";

  home = {
    username = ${user};
    
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };

  # host-specific homebrew casks
  homebrew.casks = [
    # "slack"
  ];

  # BAWAG config
#  security.pki.certificateFiles = [
#    ./bawag-certs.pem
#  ];

}

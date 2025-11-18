{
  pkgs,
  ...
}:
{
  networking.hostName = "paul-bawag";

  # host-specific homebrew casks
  homebrew.casks = [
    # "slack"
  ];

  # host-specific home-manager configuration
  home-manager.users."paul.kratochwill" = {
    programs = {
      zsh = {
        initContent = ''
          # Source shell functions
          source ${./shell-functions.sh}
        '';
      };
    };
  };

  # BAWAG config
#  security.pki.certificateFiles = [
#    ./bawag-certs.pem
#  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}

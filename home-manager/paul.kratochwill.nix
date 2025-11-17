{
  pkgs,
  user,
  ...
}:
{
  networking.hostName = "paul-bawag";

  # host-specific homebrew casks
  homebrew.casks = [
    # "slack"
  ];

  # host-specific home-manager configuration
  home-manager.users.${user} = {
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
}

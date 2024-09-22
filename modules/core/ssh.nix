{
  lib,
  pkgs,
  ...
}: let
  persistencePath = "/nix/persist/system";
in {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        # Use host keys directly from persisted path, otherwise they are not available at boot since mounting happens after agenix
        path = "${persistencePath}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  environment.persistence."${persistencePath}".files = [
    {
      file = "/etc/ssh/ssh_host_ed25519_key";
      parentDirectory = {mode = "u=rwx,g=,o=";};
    }
    {
      file = "/etc/ssh/ssh_host_ed25519_key.pub";
      parentDirectory = {mode = "u=rwx,g=,o=";};
    }
  ];
}

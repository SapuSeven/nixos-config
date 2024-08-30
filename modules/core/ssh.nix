{
  lib,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  environment.persistence."/nix/persist/system".files = [
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

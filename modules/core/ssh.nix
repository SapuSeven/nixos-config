{
  config,
  ...
}: let
  persistencePath = "/nix/persist/system";
in {
  age.secrets.nixbuild.file = ../../secrets/nixbuild.age;

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

  programs.ssh = {
    extraConfig = ''
      Host eu.nixbuild.net
        PubkeyAcceptedKeyTypes ssh-ed25519
        ServerAliveInterval 60
        IPQoS throughput
        IdentityFile ${config.age.secrets.nixbuild.path}
    '';

    knownHosts = {
      nixbuild = {
        hostNames = [ "eu.nixbuild.net" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
      };
    };
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

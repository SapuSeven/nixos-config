{
  lib,
  pkgs,
  config,
  host,
  ...
}: {
  age.secrets.restic-persist = {
    file = ../../secrets/restic-persist.age;
    owner = "restic";
  };

  #  environment.systemPackages = with pkgs; [
  #    restic
  #  ];

  users.users.restic = {
    isNormalUser = true;
  };

  security.wrappers.restic = {
    source = "${pkgs.restic.out}/bin/restic";
    owner = "restic";
    group = "users";
    permissions = "u=rwx,g=rwx,o=";
    capabilities = "cap_dac_read_search=+ep";
  };

  services.restic.backups = {
    persist = lib.mkIf (config.age.secrets.restic-persist.path != null) {
      initialize = true;
      createWrapper = true;

      paths = [
        "/nix/persist"
      ];
      repository = "/mnt/Backup/nixos-${host.name}/persist";

      passwordFile = config.age.secrets.restic-persist.path;
      user = "restic";
    };
  };
}

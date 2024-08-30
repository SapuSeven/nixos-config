{
  lib,
  pkgs,
  config,
  ...
}: {
  age.secrets.samba.file = ../../secrets/samba.age;

  environment.systemPackages = [pkgs.cifs-utils];

  fileSystems = lib.mkIf (config.age.secrets.samba != null) (let
    automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
  in {
    "/mnt/Storage" = {
      device = "//storage.lan/homes";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${config.age.secrets.samba.path},uid=1000,gid=100,file_mode=0770,dir_mode=0770"];
    };

    "/mnt/Backup" = {
      device = "//storage.lan/backup";
      fsType = "cifs";
      options = ["${automount_opts},credentials=${config.age.secrets.samba.path},uid=1000,gid=100,file_mode=0770,dir_mode=0770"];
    };
  });

  security.wrappers."mount.cifs" = {
    program = "mount.cifs";
    source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
    owner = "root";
    group = "root";
    setuid = true;
  };
}

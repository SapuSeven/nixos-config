{pkgs, host, ...}: {
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      inotify = "yes";
      media_dir = [
        "V,/run/media/${host.user}/Thicc/Videos/"
      ];
    };
  };
}

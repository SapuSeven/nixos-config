{
  config,
  ...
}: {
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      inotify = "yes";
      media_dir = [
        "V,/run/media/${config.hostConfig.primaryUser}/Thicc/Videos/"
      ];
    };
  };
}

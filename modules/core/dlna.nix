{ pkgs, ... }:
{
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      inotify = "yes";
      media_dir = [
        "V,/run/media/paul/Thicc/Videos/"
      ];
    };
  };
}

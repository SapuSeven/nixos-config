{ pkgs, ... }:
{
  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      media_dir = [
        "V,/run/media/paul/Thicc/Videos/"
      ];
    };
  };
}

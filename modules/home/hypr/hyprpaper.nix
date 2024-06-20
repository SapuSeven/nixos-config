{ pkgs, ... }:

let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Gingeh/wallpapers/main/os/nix-black-4k.png";
    sha256 = "7b54417798130689c6dfd8189b10af26e7fea993a2bb1799f4b4e384f401f6f9";
  };
  #wallpaper = pkgs.fetchurl {
    #url = "https://hyprland.org/imgs/blog/contestWinners/end_4.png";
    #sha256 = "0c5e15cefa96b5938db7ad817e29eb9447e6b0eef1efdb73600f2fa51390035e";
  #};
in
{
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      splash = true;
      splash_offset = 4.0;
      preload = "${wallpaper}";
      wallpaper = ",${wallpaper}";
    };
  };
}

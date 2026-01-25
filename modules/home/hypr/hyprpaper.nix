{pkgs, ...}: let
  wallpaper = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/os/nix-black-4k.png?raw=true";
    sha256 = "sha256-HRZYeKDmfA53kb3fZxuNWvR8cE96tLrqPZhX4+z4lZA=";
  };
  #wallpaper = pkgs.fetchurl {
  #url = "https://hyprland.org/imgs/blog/contestWinners/end_4.png";
  #sha256 = "0c5e15cefa96b5938db7ad817e29eb9447e6b0eef1efdb73600f2fa51390035e";
  #};
in {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      #      splash = true; # See https://github.com/hyprwm/hyprpaper/issues/225
      splash_offset = 4.0;
      preload = "${wallpaper}";
      wallpaper = ",${wallpaper}";
    };
  };
}

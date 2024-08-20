{ config, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      android-studio
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".android"
      ".gradle"
      ".cache/Google"
      ".config/Google"
      ".local/share/Google"
    ];
  };
}

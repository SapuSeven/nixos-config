{
  config,
  pkgs,
  ...
}: let
  android-studio = pkgs.android-studio.override {
    forceWayland = true;
    tiling_wm = true;
  };
in {
  home = {
    packages = [
      android-studio
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".android"
      #".gradle"
      ".cache/Google"
      ".config/Google"
      ".config/github-copilot"
      ".local/share/Google"
    ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}

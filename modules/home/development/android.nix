{
  config,
  pkgs,
  ...
}: let
  android-studio = pkgs.androidStudioPackages.beta.override {
    tiling_wm = true;
    forceWayland = false;
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
      ".m2"
    ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}

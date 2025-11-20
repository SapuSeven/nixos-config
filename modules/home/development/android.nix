{
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
  };

  persistence.directories = [
    ".android"
    #".gradle"
    ".cache/Google"
    ".config/Google"
    ".config/github-copilot"
    ".local/share/Google"
    ".m2"
  ];
}

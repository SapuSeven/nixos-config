{
  inputs,
  pkgs,
  host,
  ...
}: let
  lazy = inputs.lazy-apps.packages.${pkgs.stdenv.hostPlatform.system}.lazy-app;
  vmopts =
    if host.name == "desktop" # TODO: Check for a "hidpi" fact
    then ''
      -Dsun.java2d.uiScale=2
      -Dsun.java2d.metal=false
    ''
    else "";
in {
  home = {
    packages = with pkgs.jetbrains; [
      (idea.override {vmopts = vmopts;})
      (lazy.override {pkg = rust-rover.override {vmopts = vmopts;};})
      (lazy.override {pkg = pycharm.override {vmopts = vmopts;};})
      (lazy.override {pkg = webstorm.override {vmopts = vmopts;};})
    ];
  };

  persistence.directories = [
    ".config/JetBrains"
    ".local/share/JetBrains"
    ".java/.userPrefs"
  ];
}

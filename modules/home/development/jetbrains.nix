{
  inputs,
  pkgs,
  host,
  ...
}: let
  lazy = inputs.lazy-apps.packages.${pkgs.system}.lazy-app;
  vmopts =
    if host == "desktop"
    then ''
      -Dsun.java2d.uiScale=2
      -Dsun.java2d.metal=false
    ''
    else "";
in {
  home = {
    packages = with pkgs.jetbrains; [
      (idea-oss.override {vmopts = vmopts;})
      (lazy.override { pkg = (rust-rover.override {vmopts = vmopts;}); })
      (lazy.override { pkg = (pycharm-oss.override {vmopts = vmopts;}); })
      (lazy.override { pkg = (webstorm.override {vmopts = vmopts;}); })
    ];
  };

  persistence.directories = [
    ".config/JetBrains"
    ".local/share/JetBrains"
    ".java/.userPrefs"
  ];
}

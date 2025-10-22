{
  config,
  pkgs,
  host,
  ...
}: let
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
      (idea-community.override {vmopts = vmopts;})
      (rust-rover.override {vmopts = vmopts;})
      (pycharm-community.override {vmopts = vmopts;})
      (webstorm.override {vmopts = vmopts;})
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".config/JetBrains"
      ".local/share/JetBrains"
    ];
  };
}

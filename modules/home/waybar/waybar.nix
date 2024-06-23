{ pkgs, ... }: 
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
  };
}

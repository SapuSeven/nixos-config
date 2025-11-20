{
  lib,
  pkgs,
  inputs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  home.packages = lib.optionals isDarwin [
    (inputs.lazy-apps.packages.${pkgs.system}.lazy-app.override {
      pkg = pkgs.blender;
      desktopItem = pkgs.makeDesktopItem {
        name = "blender";
        exec = "blender %f";
        icon = "blender";
        desktopName = "Blender";
        genericName = "3D Modeller";
        comment = "3D modelling and animation suite";
        categories = ["Graphics" "3DGraphics" "RasterGraphics"];
        mimeTypes = ["application/x-blender"];
      };
    })
  ];
}

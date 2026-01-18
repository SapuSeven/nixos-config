{
  lib,
  pkgs,
  inputs,
  ...
}: let
  isLinux = pkgs.stdenv.isLinux;
  lazy = inputs.lazy-apps.packages.${pkgs.system}.lazy-app;
in {
  home.packages = lib.optionals isLinux [
    (lazy.override {
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
    (lazy.override { pkg = pkgs.unzip; })
  ];
}

{
  lib,
  pkgs,
  inputs,
  ...
}: let
  isLinux = pkgs.stdenv.isLinux;
  lazy = inputs.lazy-apps.packages.${pkgs.system}.lazy-app;
in {
  home.packages = with pkgs; lib.optionals isLinux [
    (lazy.override {
      pkg = blender;
      desktopItem = makeDesktopItem {
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
    (lazy.override { pkg = just; })
    (lazy.override { pkg = ansible; })
    (lazy.override { pkg = btop; })
    (lazy.override { pkg = rar; })
    (lazy.override { pkg = unzip; })
    (lazy.override { pkg = esphome; })
    (lazy.override { pkg = unzip; })
    (lazy.override { pkg = ncdu; })
    (lazy.override {
      pkg = dnsutils;
      exe = "nslookup";
    })
  ];
}

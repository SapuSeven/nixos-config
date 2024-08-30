{
  inputs,
  pkgs,
  ...
}: {
  programs.thunar.enable = true;
  programs.xfconf.enable = true;

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  environment.systemPackages = with pkgs; [
    # Thumbnail support
    webp-pixbuf-loader # .webp
    ffmpegthumbnailer # video files
    freetype # font files
    libgsf # .odf
    f3d # .glTF, .stl, .step, .ply, .obj, .fbx, ...

    # Other utilities
    xarchiver
  ];
}

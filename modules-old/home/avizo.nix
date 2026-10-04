{
  config,
  pkgs,
  ...
}: {
  home = {
    file."${config.xdg.configHome}/avizo/config.ini".text = ''
      [default]
      time = 2.0
      image-opacity = 1
      width = 250
      height = 165
      padding = 25
      y-offset = 0.86
      x-offset = 0.5
      border-radius = 12
      border-width = 2
      block-height = 3
      block-spacing = 0
      block-count = 100
      ;fade-in = 0.2
      ;fade-out = 0.5
      background = rgba(30, 30, 46, 1)
      border-color = rgba(180, 190, 254, 1)
      bar-fg-color = rgba(180, 190, 254, 1)
      bar-bg-color = rgba(17, 17, 27, 1)
    '';
    packages = with pkgs; [
      avizo
    ];
  };
}

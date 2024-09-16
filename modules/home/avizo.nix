{
  config,
  pkgs,
  ...
}: {
  home = {
    file."${config.xdg.configHome}/avizo/config.ini".text = ''
      [default]
      background=rgba(128, 135, 162, 1)
      time=2
    '';
    packages = with pkgs; [
      avizo
    ];
  };
}

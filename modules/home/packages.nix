{ inputs, pkgs, ... }: 
{
  home.packages = with pkgs; [
    xfce.thunar
    python3
    brightnessctl
  ];

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
      };
    };
  };
}

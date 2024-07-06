{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    xfce.thunar
    teamspeak5_client

    python3
  ]);

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
      };
    };
  };
}

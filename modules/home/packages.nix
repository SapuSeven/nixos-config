{ inputs, pkgs, ... }: 
{
  home.packages = (with pkgs; [
    xfce.thunar
    python3
  ]) ++ (with pkgs.stable; [
    teamspeak5_client
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

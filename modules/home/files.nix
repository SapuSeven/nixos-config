{ inputs, pkgs, ... }: 
{
  home = {
    packages = with pkgs; [
      xfce.thunar
    ];

    persistence."/nix/persist/home/paul".files = [
      ".local/share/recently-used.xbel"
    ];
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
      };
    };
  };
}

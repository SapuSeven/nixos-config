{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
    mako
  ];

  services = {
    mako = {
      enable = true;
      layer = "overlay";
      margin = "16";
      padding = "8";
      borderSize = 2;
      borderRadius = 2;
      font = "sans 12";
      defaultTimeout = 10000;
    };
  };
}

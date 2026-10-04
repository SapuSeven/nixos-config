{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
    mako
  ];

  services = {
    mako = {
      enable = true;
      settings = {
        layer = "overlay";
        margin = "16";
        padding = "8";
        border-size = 2;
        border-radius = 2;
        font = "sans 12";
        default-timeout = 10000;
      };
    };
  };
}

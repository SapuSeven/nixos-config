{pkgs, host, ...}: {
  # Enable display manager.
  services.displayManager = {
    sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
    };

    autoLogin = {
      enable = true;
      user = host.user;
    };
  };
}

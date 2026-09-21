{
  host,
  ...
}: {
  # Enable display manager.
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      autoLogin.relogin = true;
    };

    autoLogin = {
      enable = true;
      user = host.user;
    };
  };
}

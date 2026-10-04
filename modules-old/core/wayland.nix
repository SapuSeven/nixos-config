{
  ...
}: {
  services.xserver = {
    enable = true;
    updateDbusEnvironment = true;

    xkb = {
      layout = "us";
      variant = "";
      options = "compose:ralt";
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

{inputs, ...}: {
  imports = [inputs.veila.homeModules.default];

  programs.veila = {
    enable = true;
    service.enable = true;
    settings = {
      theme = "catppuccin";
    };
    idle = {
      enable = true;
      lockAfter = 300;
      lockBeforeSleep = true;
    };
  };
}

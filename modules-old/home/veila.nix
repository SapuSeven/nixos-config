{inputs, ...}: {
  imports = [inputs.veila.homeModules.default];

  programs.veila = {
    enable = true;
    service.enable = true;
    settings = {
      theme = "catppuccin";
      fingerprint.enabled = true;
      lock = {
        screenOffSeconds = 10;
        suspendSeconds = 300;
        skipSuspendWhileMediaPlaying = true;
      };
    };
    idle = {
      enable = false;
      lockAfter = 300;
      lockBeforeSleep = true;
    };
  };
}

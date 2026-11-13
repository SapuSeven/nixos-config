{
  flake.modules.nixos.host-laptop = {lib, ...}: {
    networking = {
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;

      resolvconf.dnsSingleRequest = true;
    };

    services.avahi.enable = true;
  };
}

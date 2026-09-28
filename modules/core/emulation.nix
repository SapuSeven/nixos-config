{
  lib,
  config,
  pkgs,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
  ];

  users.users = lib.genAttrs config.hostConfig.users (user: {
   extraGroups = [ "libvirtd" ];
  });
}

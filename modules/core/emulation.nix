{
  config,
  pkgs,
  host,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    dnsmasq
  ];

  users.users.${host.user}.extraGroups = ["libvirtd"];
}

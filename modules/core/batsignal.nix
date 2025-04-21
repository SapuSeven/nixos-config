{pkgs,...}: {
  environment.systemPackages = with pkgs; [
    batsignal
  ];

  systemd.user.services.batsignal = {
    enable = true;
    after = [ "default.target" ];
    wantedBy = [ "default.target" ];
    description = "Battery Monitoring Service";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''batsignal -w 25 -D "systemctl hibernate"'';
    };
  };
}

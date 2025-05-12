{pkgs, ...}: {
  home.packages = with pkgs; [
    batsignal
  ];

  systemd.user.services.batsignal = {
    Unit = {
      Description = "Battery Monitoring Service";
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = ''${pkgs.batsignal}/bin/batsignal -w 25 -D "${pkgs.systemd}/bin/systemctl hibernate"'';
    };
  };
}

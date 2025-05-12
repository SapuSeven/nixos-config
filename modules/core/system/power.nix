{pkgs, ...}: {
  services.logind.lidSwitch = "suspend-then-hibernate";

  ## Suspend to hibernate after 5% battery or 2h, whichever comes first. To change the timer:
  #  systemd.sleep.extraConfig = ''
  #    HibernateDelaySec=60min
  #  '';
}

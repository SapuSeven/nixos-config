{}: {
  # https://search.nixos.org/options?channel=24.11&show=nix.daemonCPUSchedPolicy&from=0&size=50&sort=relevance&type=packages&query=nix.daemon
  nix={
    daemonCPUSchedPolicy  = "idle"; # the idle policy may greatly improve responsiveness of a system performing expensive builds
    daemonIOSchedClass    = "idle"; #
    daemonIOSchedPriority = 7;      # N/A: With "idle", priorities are not used in scheduling decisions. range 0 (high) to 7 (low). default 4.
  };
}

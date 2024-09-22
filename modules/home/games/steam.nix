{
  lib,
  host,
  ...
}: let
  nvidiaOffloadEnabled = host == "laptop"; # config.hardware.nvidia.prime.offload.enable would be optimal, but can't figure out a way to access this property
in {
  # This config is only here for persisted home directories.
  # The configuration of the actual Steam client installation is done in modules/core/steam.nix

  home.persistence."/nix/persist/home/paul".directories = [
    ".local/share/Steam"
  ];

  xdg.desktopEntries = lib.mkIf nvidiaOffloadEnabled {
    steam = {
      name = "Steam";
      icon = "steam";
      exec = "nvidia-offload steam %U";
      terminal = false;
      categories = ["Network" "FileTransfer" "Game"];
      mimeType = ["x-scheme-handler/steam" "x-scheme-handler/steamlink"];
    };
  };
}

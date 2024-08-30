{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ftb-app
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".ftba"
      ".config/FTB\ Electron\ App"
    ];
  };
}

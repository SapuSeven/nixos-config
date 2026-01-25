{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ftb-app
    ];

    persistence."/nix/persist".directories = [
      ".ftba"
      ".config/FTB\ Electron\ App"
    ];
  };
}

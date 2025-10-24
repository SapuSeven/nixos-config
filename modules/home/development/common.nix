{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      direnv
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".local/share/direnv"
    ];
  };
}

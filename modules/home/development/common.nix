{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      direnv
    ];
  };

  persistence.directories = [
    ".local/share/direnv"
  ];
}

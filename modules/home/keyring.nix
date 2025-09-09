{pkgs, ...}:
{
  services.gnome-keyring.enable = true;

  home = {
    packages = with pkgs; [
      gcr # Provides org.gnome.keyring.SystemPrompter
      seahorse # Provides graphical keyring manager
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".local/share/keyrings"
    ];
  };
}

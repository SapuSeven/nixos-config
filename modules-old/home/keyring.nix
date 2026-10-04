{pkgs, ...}: {
  services.gnome-keyring.enable = true;

  home = {
    packages = with pkgs; [
      gcr_4 # Provides org.gnome.keyring.SystemPrompter
      seahorse # Provides graphical keyring manager
    ];

    persistence."/nix/persist".directories = [
      ".local/share/keyrings"
    ];
  };
}

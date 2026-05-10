{
  inputs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    inputs.zen-browser.homeModules.twilight
  ];

  home = {
    username = "paul";
    homeDirectory = "/home/paul";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  services.udiskie.enable = true;

  home.persistence."/nix/persist" = {
    directories = [
      "Files"
      ".gnupg" # Keyring
      ".ssh" # SSH keys and hosts
      ".config/keepassxc" # KeePassXC
      ".config/syncthing" # Syncthing
      ".config/TeamSpeak" # TeamSpeak
      ".local/state/wireplumber" # Audio setup
    ];
    files = [".zsh_history"];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}

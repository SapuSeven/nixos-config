{...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    config = {
      global.warn_timeout = "-1s";
    };
  };

  persistence.directories = [
    ".local/share/direnv"
  ];
}

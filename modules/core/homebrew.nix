{...}: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    # homebrew is best for GUI apps
    # nixpkgs is best for CLI tools
    casks = [
      # OS enhancements
      "aerospace"
      "cleanshot"
      "hiddenbar"
      "raycast"
      "betterdisplay"
      "mos"

      # dev
      "ghostty"
      "zed"

      # messaging
      #"discord"
      #"slack"
      #"signal"

      # other
      "firefox"
      #"1password"
      #"anki"
      #"brave-browser"
      "obsidian"
      #"protonvpn"
      #"spotify"
      #"thebrowsercompany-dia"
      "zen"
      "postman"
    ];
    brews = [
      "docker"
      "docker-compose"
      "colima"
    ];
    taps = [
      "nikitabobko/tap"
    ];
  };
}

{pkgs, ...}: let
  hyprpaper = pkgs.hyprpaper;

  wallpapers = "https://github.com/orangci/walls-catppuccin-mocha";

  # Script to pick the wallpaper from the repo above
  wallpaperPicker = pkgs.writeShellScriptBin "wallpaper-picker-random" ''
    REPO_URL=${wallpapers}
    TEMP_DIR=$(mktemp -d)

    echo "Fetching repository structure..."
    ${pkgs.git}/bin/git clone --depth 1 --filter=blob:none --no-checkout "$REPO_URL" "$TEMP_DIR"

    cd "$TEMP_DIR"

    echo "Listing available images..."
    IMAGES=$(${pkgs.git}/bin/git ls-tree -r --name-only HEAD | grep -E '\.(jpg|jpeg|png)$')

    if [ -z "$IMAGES" ]; then
      echo "Error: No images found in repository."
      exit 1
    fi

    SELECTED_IMAGE=$(echo "$IMAGES" | shuf -n 1)
    echo "Selected: $SELECTED_IMAGE"

    echo "Downloading image..."
    ${pkgs.git}/bin/git checkout HEAD -- "$SELECTED_IMAGE"

    echo "Setting wallpaper..."
    ${pkgs.hyprland}/bin/hyprctl hyprpaper wallpaper ",$TEMP_DIR/$SELECTED_IMAGE"

    echo "Done."
  '';
in {
  services.hyprpaper = {
    enable = true;
    package = hyprpaper;
    settings = {
      splash = false;

      # Use this for a static wallpaper:
      #preload = "${wallpaper}";
      #wallpaper = ",${wallpaper}";
    };
  };

  # Run the wallpaper picker script at boot
  systemd.user.services.wallpaper-picker = {
    Unit = {
      Description = "Wallpaper picker script";
      After = ["hyprpaper.service" "network-online.target"];
      Wants = ["network-online.target"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaperPicker}/bin/wallpaper-picker-random";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}

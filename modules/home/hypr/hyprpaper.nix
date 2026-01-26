{pkgs, ...}: let
  hyprpaper = pkgs.hyprpaper;

  wallpapers = "https://github.com/orangci/walls-catppuccin-mocha";

  # Script to pick the wallpaper from the repo above
  wallpaperPicker = pkgs.writeShellScriptBin "wallpaper-picker-random" ''
    REPO_URL=${wallpapers}
    TEMP_DIR=$(mktemp -d)

    echo "[Wallpaper Picker] Fetching repository structure..."
    ${pkgs.git}/bin/git clone --quiet --depth 1 --filter=blob:none --no-checkout "$REPO_URL" "$TEMP_DIR"

    cd "$TEMP_DIR"

    echo "[Wallpaper Picker] Listing available images..."
    IMAGES=$(${pkgs.git}/bin/git ls-tree -r --name-only HEAD | grep -E '\.(jpg|jpeg|png)$')

    if [ -z "$IMAGES" ]; then
      echo "[Wallpaper Picker] Error: No images found in repository."
      exit 1
    fi

    SELECTED_IMAGE=$(echo "$IMAGES" | shuf -n 1)
    echo "[Wallpaper Picker] Selected: $SELECTED_IMAGE"

    echo "[Wallpaper Picker] Downloading image..."
    ${pkgs.git}/bin/git checkout HEAD -- "$SELECTED_IMAGE" > /dev/null 2>&1

    echo "[Wallpaper Picker] Setting wallpaper..."
    ${pkgs.hyprland}/bin/hyprctl hyprpaper wallpaper ",$TEMP_DIR/$SELECTED_IMAGE"

    echo "[Wallpaper Picker] Done."
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
      After = ["hyprpaper.service"];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaperPicker}/bin/wallpaper-picker-random";
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}

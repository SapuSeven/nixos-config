{
  appimageTools,
  fetchurl,
  makeDesktopItem,
}: let
  pname = "ftb-app";
  version = "1.25.15";

  src = fetchurl {
    url = "https://piston.feed-the-beast.com/app/ftb-app-${version}-x86_64.AppImage";
    sha256 = "sha256-8pO/Rx9DwuEb0nhp+pkK/Jr1teVzeTeMZoO664Hx7zM=";
  };

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    desktopName = "FTB App";
    comment = "FTB Desktop App for downloading and managing Modpacks";
    categories = ["Game"];
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      mkdir -p "$out/share/applications" "$out/share/icons/hicolor/256x256/apps"
      install -Dm644 "${appimageContents}/usr/share/icons/hicolor/256x256/apps/ftb-app.png" "$out/share/icons/hicolor/256x256/apps/${pname}.png"
      install -Dm644 "${desktopItem}/share/applications/ftb-app.desktop" "$out/share/applications/${pname}.desktop"
    '';
  }

{pkgs, ...}: let
  kicad = pkgs.kicad-small.override {
    #addons = with pkgs.kicadAddons; [ kikit kikit-library ];
  };
in {
  home = {
    packages = [
      kicad
    ];

    file.".local/share/kicad/8.0/3rdparty/colors/catppuccin-kicad-mocha/catppuccin.json".source = builtins.fetchurl {
      name = "Catppuccin-Mocha-KiCad-Colors";
      url = "https://raw.githubusercontent.com/waterlilly-lilly/catppuccin-kicad/catppuccin-kicad/colors/Catppuccin%20Mocha.json";
      sha256 = "sha256:0rp377q635dv4jr8q2a5pjh1z2wzirz5vz27vxdn3qpba253ahz2";
    };

    file.".local/share/kicad/8.0/3rdparty/resources/catppuccin-kicad-mocha/icon.png".source = builtins.fetchurl {
      name = "Catppuccin-Mocha-KiCad-Icon";
      url = "https://raw.githubusercontent.com/waterlilly-lilly/catppuccin-kicad/catppuccin-kicad/resources/icon.png";
      sha256 = "sha256:1lyk7l7yj0albw6m5738lfmf8wps4j9jpsylnfxa7pss72kqm3kg";
    };
  };

  persistence.directories = [
    ".config/kicad"
    ".local/share/kicad"
  ];
}

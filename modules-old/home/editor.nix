{pkgs, ...}: let
  theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/gedit/288dcd2824be902aeb6a90d543f201ac81420242/themes/catppuccin-mocha.xml";
    hash = "sha256-X6hOAkO9Pw1ZtpAYk1/z+mATgdYfibZ9MmHm5qkHP4k=";
  };
in {
  home = {
    packages = with pkgs; [
      gnome-text-editor
    ];

    file.".local/share/libgedit-gtksourceview-300/styles/catppuccin-mocha.xml".source = theme;
  };

  dconf.settings."org/gnome/TextEditor" = {
    tab-width = 4;
  };
}

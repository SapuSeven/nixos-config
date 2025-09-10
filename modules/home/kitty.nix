{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      # for some reason, using generic font names prevents them from working
      font_family = "monospace";
      bold_font = "JetBrains Mono Bold";
      italic_font = "JetBrains Mono Italic";
      bold_italic_font = "JetBrains Mono Bold Italic";
      background_opacity = 0.9;
      background_blur = 1;
    };
  };

  home = {
    file.".config/xfce4/helpers.rc".text = ''
      TerminalEmulator=${pkgs.kitty}/bin/kitty
    '';
  };
}

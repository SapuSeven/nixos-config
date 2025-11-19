{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "JetBrainsMono Nerd Font Bold";
      italic_font = "JetBrainsMono Nerd Font Italic";
      bold_italic_font = "JetBrainsMono Nerd Font Bold Italic";
      font_features = "JetBrainsMono Nerd Font +liga +calt";
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

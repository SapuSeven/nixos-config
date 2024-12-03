{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      corefonts # Microsoft Fonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["JetBrains Mono"];
        sansSerif = ["Noto Sans"];
        serif = ["Noto Serif"];
      };
    };
  };
}

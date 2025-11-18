{ inputs, pkgs, ... }:
{
  programs.nvchad = {
    enable = true;
  };

  home = {
    packages = with pkgs; [
      # fonts
      nerd-fonts.jetbrains-mono
    ];
  };
}

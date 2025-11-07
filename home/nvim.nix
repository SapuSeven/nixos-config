{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];

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

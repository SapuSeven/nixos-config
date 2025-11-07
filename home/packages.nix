{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # dev tools
      curl
      wget
      gnupg
      tmux
      htop
      tree
      ripgrep
      gh
      zoxide

      # programming
#      mise # node, deno, bun, rust, python, etc.

      # misc
      nil
      biome
      nixfmt-rfc-style
      yt-dlp
      ffmpeg
      ollama
      azure-cli

      # qol
      #sanesidebuttons
    ];
  };
}

{ pkgs, host, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      path = "$HOME/.zsh/history";
    };

    initExtra = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';

    sessionVariables = {
      EZA_ICON_SPACING = 2;
    };

    shellAliases = {
      # Utils
      c = "clear";
      cd = "z";
      #cat = "bat";
      #nano = "micro";
      code = "codium";
      py = "python";
      #icat = "kitten icat";
      #dsize = "du -hs";
      #findw = "grep -rl";

      l = "eza -a";
      ll = "eza -la --icons --group";
      tree = "eza --icons --tree";

      # Nixos
      ns = "nix-shell --run zsh";
      nix-shell = "nix-shell --run zsh";
      nix-switch = "doas nixos-rebuild switch --flake /etc/nixos#${host}";
      nix-switchu = "doas nixos-rebuild switch --upgrade --flake /etc/nixos#${host}";
      nix-flake-update = "doas nix flake update /etc/nixos#${host}";
      nix-clean = "doas nix-collect-garbage && doas nix-collect-garbage -d && doas rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";

      # Git
      g    = "git";
      ga   = "git add";
      gaa  = "git add --all";
      gs   = "git status";
      gd   = "git diff";
      gb   = "git branch";
      gm   = "git merge";
      gl   = "git pull";
      glo  = "git pull origin";
      gp   = "git push";
      gpt  = "git push --follow-tags";
      gpo  = "git push origin";
      gc   = "git commit";
      gcm  = "git commit -m";
      gcam = "git add --all && git commit -m";
      gtag = "git tag -ma";
      gch  = "git checkout";
      gchb = "git checkout -b";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = (with pkgs; [
    eza   # ls replacement
  ]);

  home.persistence."/nix/persist/home/paul".directories = [
    ".zsh"
    ".local/share/zoxide"
  ];
}

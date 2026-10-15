{
  flake.modules.homeManager.shell = {
    lib,
    pkgs,
    osConfig,
    ...
  }: {
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

      initContent = ''
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        function print_info() {
          if [[ -e .info ]]; then
            echo -n '\n\033[0;36m 󰄾 '
            cat .info
          fi
        }
        add-zsh-hook chpwd print_info
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
        grep = "grep --color";

        l = "eza -a";
        ll = "eza -la --icons --group";
        tree = "eza --icons --tree";

        # Nixos
        ns = "nix-shell --run zsh";
        nix-shell = "nix-shell --run zsh";
        nix-switch =
          if pkgs.stdenv.hostPlatform.isDarwin
          then "sudo darwin-rebuild switch --flake /etc/nix-darwin#${osConfig.host.name}"
          else "nixos-rebuild switch --flake /etc/nixos#${osConfig.host.name} --sudo";
        nix-test = "nixos-rebuild test --flake /etc/nixos#${osConfig.host.name} --sudo";
        nix-flake-update = "nix flake update --flake /etc/nixos";
        nix-clean = "doas nix-collect-garbage && doas nix-collect-garbage -d";

        # Git
        g = "git";
        ga = "git add";
        gaa = "git add --all";
        gb = "git bisect";
        gs = "git status";
        gd = "git diff";
        gm = "git merge";
        gl = "git pull";
        glo = "git pull origin";
        gp = "git push";
        gpt = "git push --follow-tags";
        gpo = "git push origin";
        gc = "git commit";
        gcm = "git commit -m";
        gcam = "git add --all && git commit -m";
        gtag = "git tag -ma";
        gch = "git checkout";
        gchb = "git checkout -b";
        glg = "git log";

        # Python
        piv = "python -m venv .venv";
        psv = "source .venv/bin/activate";

        # Rust
        rc = "rustc";
        ci = "cargo init";
        cn = "cargo new";
        cb = "cargo build";
        cbr = "cargo build --release";
        cr = "cargo run";
        cc = "cargo check";
        ca = "cargo add";
        cu = "cargo update";
        cdoc = "cargo doc";
        cdo = "cargo doc --open";
      };
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    home.packages = with pkgs; [
      eza # ls replacement
    ];

    persistence.directories = [
      ".zsh"
      ".local/share/zoxide"
    ];
  };
}

{
  inputs,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      # fonts
      nerd-fonts.jetbrains-mono
    ];
  };

  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    # Your nvf configuration goes here
    settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      options = {
        relativenumber = true;
        number = true;

        expandtab = true;
        shiftwidth = 4;
        softtabstop = 4;
        autoindent = true;
        smartcase = true;
        smartindent = true;
      };

      keymaps = [
        {
          mode = "n";
          key = ";";
          action = ":";
          silent = false;
        }
      ];

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
        };
      };

      statusline.lualine.enable = true; # status line
      telescope.enable = true; # fuzzy finder
      autocomplete.nvim-cmp.enable = true; # fancy autocomplete
      autopairs.nvim-autopairs.enable = true; # automatic bracket pairs
      treesitter.enable = true;

      languages = {
        nix.enable = true;
        ts.enable = true;
        rust.enable = true;
        python.enable = true;
      };

      viAlias = true;
      vimAlias = true;
    };
  };

  persistence.directories = [
    ".local/state/nvim"
    ".local/share/nvim"
  ];
}

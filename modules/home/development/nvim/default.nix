{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./autocmds.nix
    ./keymaps.nix
    ./options.nix
  ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;

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

      terminal = {
        toggleterm.enable = true;
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
        };
      };

      telescope = {
        enable = true;
        extensions = [
          {
            name = "fzf";
            packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
            setup = {fzf = {fuzzy = true;};};
          }
        ];
      };

      filetree.nvimTree = {
        enable = false;
      };

      statusline.lualine.enable = true; # status line
      autocomplete.nvim-cmp.enable = true; # fancy autocomplete
      autopairs.nvim-autopairs.enable = true; # automatic bracket pairs
      #treesitter.enable = true;

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

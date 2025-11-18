{ inputs, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # fonts
      nerd-fonts.jetbrains-mono
    ];
  };

  imports = [
    # ... other imports
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

      statusline.lualine.enable = true; # status line
      telescope.enable = true; # fuzzy finder
      autocomplete.nvim-cmp.enable = true; # fancy autocomplete

#      options = {
#        relativenumber = true;
#        number = true;
#      };

      languages = {
        lsp.enable = true;
        treesitter.enable = true;

        nix = {
          enable = true;
          lsp = {
            enable = true;
            server = "nixd";
          };
        };
        ts.enable = true;
        rust.enable = true;
      };
    };
  };

#  persistence.directories = [
#    ".config/nvim"
#    ".local/state/nvim"
#    ".local/share/nvim"
#  ];
}

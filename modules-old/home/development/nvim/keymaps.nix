{
  programs.nvf.settings.vim.keymaps = [
    {
      key = ";";
      mode = "n";
      action = ":";
      silent = false;
      desc = "Command mode shortcut";
    }
    {
      key = "<Esc>";
      mode = "n";
      action = "<cmd>nohlsearch<CR>";
      desc = "Clear search highlight";
    }
  ];
}

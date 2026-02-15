{inputs, ...}: {
  imports = [ inputs.ags-bar.homeManagerModules.default ];

  programs.ags-bar = {
    enable = true;
  };
}

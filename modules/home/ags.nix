{inputs, ...}: {
  imports = [ inputs.ags-bar.homeManagerModules.default ];

  programs.ags-bar = {
    enable = true;

    # symlink to ~/.config/ags
    #configDir = inputs.ags.outPath + "/config";
  };
}

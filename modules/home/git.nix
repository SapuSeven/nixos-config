{...}: {
  programs.git = {
    enable = true;
    settings = {
      safe = {directory = "/etc/nixos/.git";};
      user = {
        name = "SapuSeven";
        email = "sapuseven@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
    };

    lfs.enable = true;
    ignores = ["**/.DS_STORE"];
  };
}

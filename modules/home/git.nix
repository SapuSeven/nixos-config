{...}: {
  programs.git = {
    enable = true;
    settings = {
      safe = {directory = "/etc/nixos/.git";};
      user = {
        name = "SapuSeven";
        email = "sapuseven@gmail.com";
      };
    };
  };
}

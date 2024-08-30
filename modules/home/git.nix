{...}: {
  programs.git = {
    enable = true;
    userName = "SapuSeven";
    userEmail = "sapuseven@gmail.com";
    extraConfig = {
      safe = {directory = "/etc/nixos/.git";};
    };
  };
}

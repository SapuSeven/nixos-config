{
  pkgs,
  system,
  inputs,
  self,
  user,
  ...
}:
{
  # macOS-specific settings
  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };
  environment = {
    systemPath = [
      "/opt/homebrew/bin"
    ];
    pathsToLink = [ "/Applications" ];
  };
};


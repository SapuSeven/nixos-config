{ primaryUser, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Paul Kratochwill";
        email = "paul.kratochwill@bawaggroup.com";
      };

      github = {
        user = primaryUser;
      };

      init = {
        defaultBranch = "main";
      };
    };

    lfs.enable = true;

    ignores = [ "**/.DS_STORE" ];
  };
}

{
  pkgs,
  user,
  ...
}: let
  user = "paul.kratochwill";
in
{
  home = {
    username = user;

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };
}

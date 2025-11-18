{
  pkgs,
  ...
}: let
  user = "paul.kratochwill";
in
{
  home = {
    username = user;

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };
}

{
  lib,
  host,
  ...
}: let
  user = host.user;
in {
  programs.git.settings.user = lib.mkForce {
    name = "Paul Kratochwill";
    email = "paul.kratochwill@bawaggroup.com";
  };

  home = {
    username = user;

    # create .hushlogin file to suppress login messages
    file.".hushlogin".text = "";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "25.05";
  };
}

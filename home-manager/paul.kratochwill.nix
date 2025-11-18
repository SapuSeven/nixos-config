{
  pkgs,
  inputs,
  host,
  ...
}: let
  user = host.user;
in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes:
    inputs.nix4nvchad.homeManagerModule
  ];

  programs.git.settings.user = lib.mkIf (host.name == "macbook") {
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

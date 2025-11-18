{...}: {
  imports = [
    ./configuration-darwin.nix
    ./hardware-configuration.macbook.nix
  ];

  programs.git.settings.user = {
    name = "Paul Kratochwill";
    email = "paul.kratochwill@bawaggroup.com";
  };
}

{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      httptoolkit
    ];

    persistence."/nix/persist".directories = [".config/httptoolkit"];
  };
}

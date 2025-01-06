{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      httptoolkit
    ];

    persistence."/nix/persist/home/paul".directories = [".config/httptoolkit"];
  };
}

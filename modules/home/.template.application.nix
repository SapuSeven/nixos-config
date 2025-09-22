{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      FIXME
    ];

    persistence."/nix/persist/home/paul".directories = [
      ".config/FIXME"
    ];
  };  
}

{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      musescore
    ];

    persistence."/nix/persist".directories = [".config/MuseScore"];
  };
}

{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      libreoffice-qt
      hunspell
      hunspellDicts.de_AT
    ];
  };
}

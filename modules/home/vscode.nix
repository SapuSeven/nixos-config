{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions;
        [
          # nix language
          bbenoist.nix
          # nix-shell suport
          arrterian.nix-env-selector
          # python
          ms-python.python
          # C/C++
          ms-vscode.cpptools

          # Color theme
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "platformio-ide";
            publisher = "platformio";
            version = "3.3.3";
            sha256 = "sha256-cVYnFhdeClHhuVaTWRU2IDIA1mFq1iLveZUIhEhMSck=";
          }
        ];
      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont', 'monospace', monospace";
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont'";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "editor.lineHeight" = 1.5;
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "workbench.startupEditor" = "none";
        "security.workspace.trust.enabled" = false;
        "platformio-ide.autoOpenPlatformIOIniFile" = false;
        "platformio-ide.disablePIOHomeStartup" = true;
      };
    };
  };

  home.persistence."/nix/persist/home/paul".directories = [
    ".platformio"
  ];
}

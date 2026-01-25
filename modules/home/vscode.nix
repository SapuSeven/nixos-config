{
  pkgs,
  ...
}: {
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
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "monkey-c";
            publisher = "garmin";
            version = "1.1.2";
            sha256 = "sha256-+cZmPJsH6KYCm02s011QYIuzoBejFNfZaj3uYX9rbYQ=";
          }
          {
            name = "platformio-ide";
            publisher = "platformio";
            version = "3.3.3";
            sha256 = "sha256-cVYnFhdeClHhuVaTWRU2IDIA1mFq1iLveZUIhEhMSck=";
          }
        ];
      userSettings = {
        "window.titleBarStyle" = "custom";
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont', 'monospace', monospace";
        "editor.fontSize" = 14;
        "editor.fontLigatures" = true;
        "editor.lineHeight" = 1.5;
        "editor.semanticHighlighting.enabled" = true;
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont'";
        "terminal.integrated.minimumContrastRatio" = 1;
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "workbench.startupEditor" = "none";
        "security.workspace.trust.enabled" = false;
        "platformio-ide.autoOpenPlatformIOIniFile" = false;
        "platformio-ide.disablePIOHomeStartup" = true;
        "git.confirmSync" = false;
        "update.mode" = "none";
      };
    };
  };

  persistence."/nix/persist".directories = [
    ".platformio"
  ];
}

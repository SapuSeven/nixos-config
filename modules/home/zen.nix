# Loosely based on https://github.com/oddlama/nix-config/blob/main/users/myuser/graphical/firefox.nix
{
  lib,
  pkgs,
  ...
}: {
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      extensions.settings = lib.mkForce {};
      search = {
        force = true;
        default = "Kagi";

        engines = {
          "Kagi" = {
            icon = "https://kagi.com/favicon.ico";
            urls = [
              {
                template = "https://kagi.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };
        };
      };

      settings = {
        # General
        "intl.accept_languages" = "en-US,en";
        "browser.startup.page" = 3; # Resume previous session on startup
        "browser.fullscreen.autohide" = false; # More comfortable fullscreen for tiling WMs
        "browser.aboutConfig.showWarning" = false; # I know what I'm doing
        "browser.download.useDownloadDir" = false; # Ask where to save stuff
        "browser.translations.neverTranslateLanguages" = "de"; # No need
        "privacy.clearOnShutdown.history" = false; # We want to save history on exit
        "devtools.chrome.enabled" = true; # Allow executing JS in the dev console
        "general.autoScroll" = true;
        "browser.fixup.domainsuffixwhitelist.lan" = true; # Add .lan as a recognized TLD
        "browser.sessionstore.restore_pinned_tabs_on_demand" = false; # Load pinned and essential tabs immediately on start
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Add userChrome.css support

        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;

        "beacon.enabled" = false; # No bluetooth location
        "device.sensors.enabled" = false; # This isn't a phone
        "geo.enabled" = false; # Disable geolocation alltogether

        "extensions.pocket.enabled" = false; # disable pocket, save links, send tabs
        "browser.contentblocking.report.lockwise.enabled" = false; # don't use firefox password manger
        "browser.uitour.enabled" = false; # no tutorial
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      };

      userChrome = builtins.readFile (
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zen-browser";
          rev = "main";
          sha256 = "sha256-5A57Lyctq497SSph7B+ucuEyF1gGVTsuI3zuBItGfg4=";
        }
        + "/themes/Mocha/Mauve/userChrome.css"
      );
    };
  };

  persistence.directories = [
    ".config/zen/default"
  ];
}

# Loosely based on https://github.com/oddlama/nix-config/blob/main/users/myuser/graphical/firefox.nix

{ pkgs, ... }: 
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };

      settings = {
        # General
        "intl.accept_languages" = "en-US,en";
        "browser.startup.page" = 3; # Resume previous session on startup
        "browser.aboutConfig.showWarning" = false; # I know what I'm doing
        "browser.download.useDownloadDir" = false; # Ask where to save stuff
        "browser.translations.neverTranslateLanguages" = "de"; # No need
        "privacy.clearOnShutdown.history" = false; # We want to save history on exit
        "devtools.chrome.enabled" = true; # Allow executing JS in the dev console
        "general.autoScroll" = true;
        "browser.fixup.domainsuffixwhitelist.lan" = true; # Add .lan as a recognized TLD

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
    };
  };


  home.persistence."/nix/persist/home/paul".directories = [
    ".mozilla"
  ];
}

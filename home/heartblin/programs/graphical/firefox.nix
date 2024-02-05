{ inputs, pkgs, ... }:

{
  home.sessionVariables.BROWSER = "firefox";

  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/heartblin/chrome/firefox-gnome-theme";
    source = inputs.firefox-gnome-theme;
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.heartblin = {
      name = "HeartBlin";
      settings = {
        # For GNOME Theme
        # "gnomeTheme.hideSingleTab" = true;
        # "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        # "gnomeTheme.normalWidthTabs" = false;
        # "gnomeTheme.tabsAsHeaderbar" = false;

        "browser.tabs.loadInBackground" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';

      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
      
      extraConfig = builtins.readFile "${inputs.firefox-gnome-theme}/configuration/user.js";

      extensions = with inputs.firefox-addons.packages."${pkgs.system}"; [
        bitwarden
        darkreader
        ublock-origin
        sponsorblock
        terms-of-service-didnt-read
      ];
    };
  };
}
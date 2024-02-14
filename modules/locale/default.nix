{ pkgs, lib, ... }: let
  en = "en_US.UTF-8";
  ro = "ro_RO.UTF-8";
in {
  time = {
    timeZone = "Europe/Bucharest";
    hardwareClockInLocalTime = true;
  };

  i18n = {
    extraLocaleSettings = {
      LANG = en;
      LC_COLLATE = en;
      LC_CTYPE = en;
      LC_MESSAGES = en;

      LC_ADDRESS = ro;
      LC_IDENTIFICATION = ro;
      LC_MEASUREMENT = ro;
      LC_MONETARY = ro;
      LC_NAME = ro;
      LC_NUMERIC = ro;
      LC_PAPER = ro;
      LC_TELEPHONE = ro;
      LC_TIME = ro;
    };

    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
    ];

    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = [
        pkgs.fcitx5-gtk
        pkgs.fcitx5-lua
        pkgs.libsForQt5.fcitx5-qt
        pkgs.fcitx5-material-color
      ];
    };
  };
}

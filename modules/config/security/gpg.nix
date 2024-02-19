{ config, lib, pkgs, ... }: let
  cfg = config.gpg;
in {
  config = lib.mkIf cfg.enable {
    services.pcscd.enable = true;
    environment.systemPackages = with pkgs; [
      # pinentry-curses
      pinentry-gnome
    ];

    programs.gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSSHSupport = true;
    };
  };
}

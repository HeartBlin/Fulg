{ config, pkgs, ... }: let
  user = config.modules.users;
in {
  services.pcscd.enable = true;
  environment.systemPackages = with pkgs; [
    pinentry-curses
    pinentry-gnome
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    enableSSHSupport = true;
  };

  home-manager.users.${user.userName} = hm: {
    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
      pinentryFlavor = "curses";
    };
  };
}
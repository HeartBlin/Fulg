{ config, lib, pkgs, ... }: let
  cfg = config.modules.programs.transmission;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.transmission-gtk
    ];

    #networking.firewall = 
  };
}
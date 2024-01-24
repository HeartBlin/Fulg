{ config, lib, pkgs, ... }: let
  cfg = config.modules.programs.virtualisation.distrobox;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.podman-compose
      pkgs.podman-desktop
    ];

    virtualisation.podman = {
      enable = true;

      dockerCompat = true;
      dockerSocket.enable = true;

      defaultNetwork.settings.dns_enabled = true;

      enableNvidia = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;

      autoPrune = {
        enable = true;
        flags = ["--all"];
        dates = "weekly";
      };
    };
  };
}
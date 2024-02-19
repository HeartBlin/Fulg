{ config, lib, pkgs, ... }: let
  cfg = config.network.tailscale;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.tailscale
    ];

    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath = "loose";
    };

    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}

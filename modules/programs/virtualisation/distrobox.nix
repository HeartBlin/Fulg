{ config, lib, pkgs, ... }: let
  cfg = config.modules.programs.virtualisation.distrobox;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.distrobox
    ];

    systemd.user = {
      timers."distrobox-update" = {
        enable = true;
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "1h";
          OnUnitActiveSec = "id";
          Unit = "distrobox-update.service";
        };
      };

      services."distrobox-update" = {
        enable = true;
        serviceConfig.Type = "oneshot";
        script = ''
          ${pkgs.distrobox}/bin/distrobox upgrade --all
        '';
      };
    };
  };
}
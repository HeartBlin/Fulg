{ config, lib, pkgs, ... }: let
  cfg = config.modules.device.asus;
in {
  config = lib.mkIf cfg.enable {
    systemd.services.supergfxd.path = [ pkgs.pciutils ];
    services = {
      supergfxd.enable = true;
      asusd = {
        enable = true;
        enableUserService = true;
      };
    };

    systemd.user.services."asusctl-start" = {
        enable = true;
        wantedBy = [ "default.target" ];

        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = "yes";

        script = ''
          ${pkgs.asusctl}/bin/asusctl led-mode rainbow &
          ${pkgs.asusctl}/bin/asusctl -k med
        '';
      };
  };
}
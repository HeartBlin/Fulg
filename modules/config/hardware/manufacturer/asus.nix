{ config, lib, pkgs, ... }: let
  role = config.role;
  cfg = config.device.manufacturer;
in {
  config = lib.mkIf ( cfg == "asus" ) {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to assign manufacturer!";
      }
    ];

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

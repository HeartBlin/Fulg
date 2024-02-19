{ config, lib, pkgs, ... }: let
  role = config.role;
  cfg = config.boot.graphicalBoot;
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to use graphicalBoot!";
      }
      {
        assertion = role != "server";
        message = "Servers aren't allowed to use graphicalBoot!";
      }
    ];
    boot = {
      initrd.systemd.enable = lib.mkForce true;

      kernelParams = [
        "quiet"
        "udev.log_priority=3"
      ];

      plymouth = {
        enable = true;
        theme = "bgrt";
      };
    };

    environment.systemPackages = [
      pkgs.plymouth
    ];
  };
}

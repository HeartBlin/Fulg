{ config, lib, pkgs, ... }: let
  cfg = config.modules.boot;
in {
  config = lib.mkIf cfg.plymouth.enable {
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
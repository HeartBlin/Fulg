{ config, lib, pkgs, ... }: let
  cfg = config.modules.device.bluetooth;
in {
  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      powerOnBoot = true;
    };

    # https://nixos.wiki/wiki/Bluetooth
    services.blueman.enable = true;
  };
}
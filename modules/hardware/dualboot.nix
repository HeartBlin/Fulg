{ config, lib, ... }: let
  cfg = config.modules.device.dualboot;
in {
  config = lib.mkIf cfg.enable {
    time.hardwareClockInLocalTime = true;
  };
}
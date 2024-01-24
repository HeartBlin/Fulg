{ config, lib, ... }: let
  cfg = config.modules.programs.gamemode;
in {
    config = lib.mkIf cfg.enable {
    # Allow games to request optimizations 
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings.general = {
        desiredgov = "performance";
        softrealtime = "auto";
        renice = 10;
        inhibit_screensaver = 1;
      };
    };
  };
}
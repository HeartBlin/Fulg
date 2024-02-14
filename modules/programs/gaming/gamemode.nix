{ config, lib, pkgs,... }: let
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
        renice = 15;
        inhibit_screensaver = 1;
      };
    };

    security.wrappers = {
      gamemode = {
        owner = "root";
        group = "root";
        source = "${pkgs.gamemode}/bin/gamemoderun";
        capabilities = "cap_sys_ptrace,cap_sys_nice+pie";
      };
    };
  };
}

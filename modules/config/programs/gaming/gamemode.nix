{ config, lib, pkgs,... }: let
  role = config.role;
  cfg = config.programs.gaming.gamemode;
in {
    config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to install gamemode!";
      }
      {
        assertion = role != "server";
        message = "Servers aren't allowed to install gamemode!";
      }
    ];

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

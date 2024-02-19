{ config, lib, pkgs, ... }: let
  role = config.role;
  cfg = config.programs.gaming.steam;
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to install Steam!";
      }
      {
        assertion = role != "server";
        message = "Servers aren't allowed to install Steam!";
      }
    ];

    # Set up Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    nixpkgs.overlays = [
      (_: prev: {
        steam = prev.steam.override {
          extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${pkgs.proton-ge-custom}'";
        };
      })
    ];
  };
}

{ config, lib, pkgs, ... }: let
  cfg = config.modules.programs.steam;
in {
  config = lib.mkIf cfg.enable {
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
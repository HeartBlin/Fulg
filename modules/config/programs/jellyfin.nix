{ config, lib, pkgs, ... }: let
  role = config.role;
  cfg = config.programs.jellyfin;
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = role != "workstation";
        message = "Workstations aren't allowed to host Jellyfin instances!";
      }
      {
        assertion = role != "iso";
        message = "ISOs can't host Jellyfin instances!";
      }
    ];

    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];

    # Enable jellyfin
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}

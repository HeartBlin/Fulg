{ config, lib, pkgs, ... }: let
  cfg = config.device.audio;
in {
  imports = [
    ./low-latency.nix
  ];

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      audio.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    environment.systemPackages = [
      pkgs.pavucontrol
    ];

    hardware.pulseaudio.enable = !config.services.pipewire.enable;

    systemd.user.services = {
      pipewire.wantedBy = [ "default.target" ];
      pipewire-pulse.wantedBy = [ "default.target" ];
    };
  };
}

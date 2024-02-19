{ inputs, config, lib, ... }: let
  cfg = config.device.audio;
in {
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];

  config = lib.mkIf cfg.lowLatency.enable {
    assertions = [
      {
        assertion = cfg.enable == true;
        message = "To use low-latency, you actually need to enable audio!";
      }
    ];
    services.pipewire = {
      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };
  };
}

{ config, inputs, lib, ... }: let
  cfg = config.modules.programs.virtualisation.macos;
in
{
  imports = [
    inputs.nixtheplanet.nixosModules.macos-ventura
  ];
  config = lib.mkIf cfg.enable {
    services.macos-ventura = {
      enable = true;
      openFirewall = true;
      vncListenAddr = "0.0.0.0";
    };
  };
}
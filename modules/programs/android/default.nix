{ config, lib, pkgs, ... }: let
  cfg = config.modules.programs.adb;
  user = config.modules.users.userName;
in {
  config = lib.mkIf cfg.enable {
    # Enable ADB systemwide
    programs.adb.enable = true;
    
    # Permit the user to use ADB
    users.users."${user}".extraGroups = [ "adbusers" ];

    # Install scrcpy
    environment.systemPackages = [
      pkgs.scrcpy
    ];
  };
}
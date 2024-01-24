# I will comment only the 'lib.mkOption' options
# as 'lib.mkEnableOption' explains itself

{ lib, ... }:

{
  options.modules = {
    device = {
      # Set the CPU type of the system
      cpu =
        lib.mkOption { type = lib.types.str; };

      # Set the GPU type of the system
      gpu =
        lib.mkOption { type = lib.types.str; };
    };

    users = {
      # Set the username of the system
      userName = 
        lib.mkOption { type = lib.types.str; };
    };

    boot = {  
      secureBoot = 
        lib.mkEnableOption "Enable SecureBoot support";
    };

    impermanence.enable = 
      lib.mkEnableOption "Enable impermanence on '/'";

    programs = {
      gamemode.enable = 
        lib.mkEnableOption "Enable Gamemode";

      steam.enable = 
        lib.mkEnableOption "Enable Steam";

      wayland.hyprland.enable = 
        lib.mkEnableOption "Enable the Hyprland compositor";
    };
  };
}
{ ... }:

{
  config = {
    modules = {
      boot = {
        secureBoot = true;
      };

      device = {
        cpu = "amd";
        gpu = "nvidia";
      };

      programs = {
        gamemode.enable = true;
        steam.enable = true;
        
        wayland.hyprland.enable = true;
      };

      users.userName = "heartblin";
      
      impermanence.enable = true;
    };
  };
}
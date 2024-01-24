{ ... }:

{
  config = {
    modules = {
      boot = {
        secureBoot.enable = true;
        plymouth.enable = true;
      };

      device = {
        cpu = "amd";
        gpu = "nvidia";
      };

      programs = {
        gamemode.enable = true;
        steam.enable = true;

        virtualisation = {
          distrobox.enable = true;
          waydroid.enable = true;
        };
        
        wayland.hyprland.enable = true;
      };

      users.userName = "heartblin";
      
      encryption.enable = true;
      impermanence.enable = true;
    };
  };
}
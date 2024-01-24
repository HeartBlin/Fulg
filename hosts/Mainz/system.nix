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
        wayland.hyprland.enable = true;
      };

      users.userName = "heartblin";
      
      impermanence.enable = true;
    };
  };
}
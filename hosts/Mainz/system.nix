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

      users.userName = "heartblin";
      
      impermanence.enable = true;
    };
  };
}
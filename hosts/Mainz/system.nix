{ ... }:

{
  config = {
    modules = {
      boot = {
        secureBoot = true;
      };

      users.userName = "heartblin";

      impermanence.enable = true;
    };
  };
}
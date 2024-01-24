{ config, ... }: let
  user = config.modules.users.userName;
in {
  home-manager.users.${user} = {
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
  };
}
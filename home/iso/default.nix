## Entry point of ISO HM config

{ config, inputs, ... }: let
  user = config.modules.users;
  configHM = config;
in {
    home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs configHM; };
    users.${user.userName} = {
      programs.home-manager.enable = true;
      home.stateVersion = "23.11";
    };
  };
}

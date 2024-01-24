# Entry point of HM config

{ config, inputs, ... }: let
  user = config.modules.users;
  configHM = config;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs configHM; };
    users.${user.userName} = import ./${user.userName};
  };
}
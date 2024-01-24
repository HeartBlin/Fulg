# Home manager
# Nothing is imported in HM, only in NixOS
# This allows me to not have split files 
# ex. a Hyprland HM config file & a Hyprland NixOS module

{ inputs, ... }:

{
  imports = [
    ./heartblin # Had to hardcode this in :(
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
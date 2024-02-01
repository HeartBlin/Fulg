{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.jetbrains.idea-community
    pkgs.jetbrains-toolbox
  ];
}
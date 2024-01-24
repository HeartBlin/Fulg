{ pkgs, ... }:

{
  home.packages = [
    pkgs.gnome.nautilus
    pkgs.nautilus-open-any-terminal
    pkgs.gnome.sushi
  ];
}
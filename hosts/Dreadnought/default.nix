{ lib, pkgs, ... }:

{
  imports = [
    ./system.nix
  ];

  system.stateVersion = lib.mkForce "24.05";
  networking.wireless.enable = lib.mkForce false;
  services.flatpak.enable = lib.mkForce false;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_6;
}

{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Tweaks
  security = {
    protectKernelImage = true;
  };

  # Firmware updates
  services.fwupd.enable = true;
}
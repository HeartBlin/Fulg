{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Tweaks
  security = {
    protectKernelImage = true;
  };

  # Firmware updates
  services.fwupd.enable = true;
}
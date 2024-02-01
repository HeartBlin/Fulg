{ inputs, pkgs, ... }:

{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Tweaks
  security = {
    protectKernelImage = true;
  };
}
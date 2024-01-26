{ inputs, pkgs, ... }:

{
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Tweaks
  security = {
    protectKernelImage = true;
  };
}
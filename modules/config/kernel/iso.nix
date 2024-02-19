{ config, lib, pkgs, ... }: let
  role = config.role;
in {
  config = lib.mkIf ( role == "iso") {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    security = {
      protectKernelImage = true;
    };
  };
}

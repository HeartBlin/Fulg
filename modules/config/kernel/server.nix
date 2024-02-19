{ config, lib, pkgs, ... }: let
  role = config.role;
in {
  config = lib.mkIf ( role == "server") {
    boot.kernelPackages = pkgs.linuxPackages_hardened;

    security = {
      protectKernelImage = true;
    };

    services.fwupd.enable = true;
  };
}


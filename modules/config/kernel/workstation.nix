{ config, lib, pkgs, ... }: let
  role = config.role;
in {
  config = lib.mkIf ( role == "workstation" ) {
    boot.kernelPackages = pkgs.linuxPackages_zen;

    security = {
      protectKernelImage = true;
    };

    services.fwupd.enable = true;
  };
}

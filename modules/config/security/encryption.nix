{ config, lib, pkgs, ... }: let
  role = config.role;
  cfg = config.encryption;
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to have encrypted FS!";
      }
    ];

    boot = {
      # Speed improvements
      initrd.availableKernelModules = [
        "aesni_intel"
        "cryptd"
        "usb_storage"
      ];

      # I encrypt a USB stick, it is on NTFS
      supportedFilesystems = [
        "ntfs"
      ];

      # No timeout
      kernelParams = [
        "luks.option=timeout=0"
        "rd.luks.options=timeout=0"
        "rootflags=x-systemd.device-timeout=0"
      ];

      initrd.luks.devices."enc" = {
        bypassWorkqueues = true;
        preLVM = true;
      };
    };

    environment.systemPackages = [
      pkgs.veracrypt
    ];

    services.lvm.enable = true;
  };
}

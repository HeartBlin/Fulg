{ ... }:

{
  # Enable systemd-boot, no SecureBoot support
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
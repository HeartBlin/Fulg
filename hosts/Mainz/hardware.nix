{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/e54b8058-f6a0-4534-be84-af6804ae4f10";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" ];
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/21e0ccf1-0383-4509-bba6-cc52c743c368";

  fileSystems."/home" ={
    device = "/dev/disk/by-uuid/e54b8058-f6a0-4534-be84-af6804ae4f10";
    fsType = "btrfs";
    options = [ "subvol=home" "compress=zstd" "noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/e54b8058-f6a0-4534-be84-af6804ae4f10";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/e54b8058-f6a0-4534-be84-af6804ae4f10";
    fsType = "btrfs";
    options = [ "subvol=persist" ];
    neededForBoot = true;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/e54b8058-f6a0-4534-be84-af6804ae4f10";
    fsType = "btrfs";
    options = [ "subvol=log" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/78AD-05F1";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/637b2d04-7a47-4b73-afaa-7abac1a3c92a"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
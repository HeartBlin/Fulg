{ config, lib, pkgs, ... }: let
  # Use the latest drivers
  stable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  beta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage =
    if (lib.versionOlder beta stable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

  role = config.role;
  cfg = config.device;
in {
  config = lib.mkIf ( cfg.gpu == "nvidia" ) {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to assign GPUs!";
      }
    ];

    # Nvidia packages are unfree
    nixpkgs.config.allowUnfree = true;

    # Use the driver
    services.xserver.videoDrivers = [ "nvidia" ];

    # Blacklist nouveau
    boot.blacklistedKernelModules = [ "nouveau" ];

    # Kernel params
    boot.kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
    ];

    hardware.nvidia = {
      package = nvidiaPackage;
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      dynamicBoost.enable = true;
      open = false;
      nvidiaSettings = true;
      nvidiaPersistenced = true;
      forceFullCompositionPipeline = true;

      # Laptop
      prime = {
        reverseSync.enable = true;
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    # Vulkan
    environment.systemPackages = [
      pkgs.vulkan-tools
      pkgs.vulkan-loader
      pkgs.vulkan-validation-layers
      pkgs.libva
      pkgs.libva-utils
    ];

    # OpenGL config
    hardware.opengl = {
      enable = true;
      extraPackages = [ pkgs.nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
    };
  };
}


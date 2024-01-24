{ config, lib,... }: let
  cfg = config.modules.device;
in {
  config = lib.mkIf ( cfg.cpu == "amd" ) {
    boot = {
      kernelModules = [
        "kvm-amd" # Virt
        "msr" # MSR access
      ];

      kernelParams = [ "amd_pstate=active" ];
    };

    # Update the μcode
    hardware.cpu.amd.updateMicrocode = true;
  };
}
{ config, lib,... }: let
  role = config.role;
  cfg = config.device;
in {
  config = lib.mkIf ( cfg.cpu == "amd" ) {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to assign CPUs!";
      }
    ];

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

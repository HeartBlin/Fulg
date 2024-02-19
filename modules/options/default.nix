{ lib, ... }:

{
  options = {
    # Set the role of the host, needed!
    # Valid roles: 'workstation'  'server'  'iso'
    role = lib.mkOption { type = lib.types.str; };

    # Set username
    user.userName =
      lib.mkOption { type = lib.types.str; };

    # Boot options
    boot = {
      graphicalBoot.enable =
        lib.mkEnableOption "Enable 'plymouth'";

      secureBoot.enable =
        lib.mkEnableOption "Enable 'secureboot' support";
    };

    # Hardware options
    device = {
      # Set the CPU type of the system
      cpu =
        lib.mkOption { type = lib.types.str; };

      # Set the GPU type of the system
      gpu =
        lib.mkOption { type = lib.types.str; };

      # Set the PC vendor
      manufacturer =
        lib.mkOption { type = lib.types.str; };

      # Audio options
      audio = {
        enable =
          lib.mkEnableOption "Enable 'pipewire'";

        lowLatency.enable =
          lib.mkEnableOption "Enable tweaks to pipewire";
      };

      bluetooth.enable =
        lib.mkEnableOption "Enable bluetooth radio";
    };

    impermanence.enable =
      lib.mkEnableOption "Enable 'impermanence'";

    network = {
      tailscale.enable =
        lib.mkEnableOption "Enable 'tailscale'";
    };

    encryption.enable =
      lib.mkEnableOption "Enable 'encryption' tweaks";

    gpg.enable =
      lib.mkEnableOption "Enable GnuPG";

    # Program options
    programs = {
      wayland.hyprland.enable =
        lib.mkEnableOption "Enable the 'hyprland' wayland compositor";

      gaming.steam.enable =
        lib.mkEnableOption "Enable the Steam game platform";

      gaming.gamemode.enable =
        lib.mkEnableOption "Enable 'gamemode'";
    };
  };
}

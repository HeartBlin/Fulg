{ config, inputs, lib, pkgs, ... }: let
  cfg = config.modules.programs.wayland.hyprland;
in {
  config = lib.mkIf cfg.enable {
    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
    };

    # Display manager
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };

    # Get Hyprland as a choice in display managers
    services.xserver.displayManager.sessionPackages = [
      inputs.hyprland.packages.x86_64-linux.default
    ];

    # Auto-mount USB sticks
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    # Gnome-keyring shenanigans
    security.polkit.enable = true;
    systemd.user.services.polkit-gnome = {
      description = "Launches polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    # Brightness
    hardware.brillo.enable = true;

    # XDG-portal
    xdg.portal.enable = true;
  };
}

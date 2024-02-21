{ config, inputs, lib, pkgs, ... }: let
  role = config.role;
in {
  config = lib.mkIf ( role == "server" ) {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # 'command-not-found' does not work anyway, use nix-index
    programs.command-not-found.enable = false;

    # Needed for 'nh'
    environment = {
      sessionVariables.FLAKE = "/etc/nixos/";
      systemPackages = [
        pkgs.git # Flakes need this
        inputs.nh.packages.${pkgs.system}.default
        inputs.nix-index.packages.${pkgs.system}.default
      ];
    };

    # Faster rebuilds
    documentation = {
      doc.enable = false;
      info.enable = false;
      man.enable = false;
      nixos.enable = false;
    };

    nix = {
      # Make rebuilds a lower priority
      daemonCPUSchedPolicy = "batch";
      daemonIOSchedClass = "idle";
      daemonIOSchedPriority = 5;

      # Garbage collection
      gc = {
        automatic = true;
        dates = "Sunday *-*-* 04:00";
        options = "--delete-older-than 3d";
      };

      # Optimise store
      optimise = {
        automatic = true;
        dates = [ "04:00" ];
      };

      settings = {
        # Only the whell group can invoke nix commands
        allowed-users = [ "@wheel" ];

        # Enable flakes
        experimental-features = [ "nix-command" "flakes" "cgroups" ];

        # Accept nix flakes by default
        accept-flake-config = true;

        # Build inside cgroups
        use-cgroups = true;

        # Build in sandbox
        sandbox = true;

        # Stop telling me it is dirty IK
        warn-dirty = false;

        # Show me more logs
        log-lines = 40;

        # Parallel TCP connections
        # '0' means as many as it wants
        http-connections = 0;

        trusted-users = [ "root" "@wheel" ];

        # substituters, we are not on Gentoo to compile everything
        builders-use-substitutes = true;
        substituters = [
          "https://cache.nixos.org?priority=10" # High prio
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };

    # Don't autoupdate
    system.autoUpgrade.enable = false;

    # Change this if you know what you are doing
    system.stateVersion = "24.05";
  };
}

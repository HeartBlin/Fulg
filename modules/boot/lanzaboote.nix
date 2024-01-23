{ config, inputs, lib, pkgs, ... }: let
  cfg = config.modules.boot;
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Enable lanzaboote, aka enable SecureBoot
  # Will require additional steps
  # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  config = lib.mkIf cfg.secureBoot {
    boot = {
      bootspec.enable = true;

      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };

      # We don't need the normal systemd-boot anymore
      loader.systemd-boot.enable = lib.mkForce false;
    };

    environment.systemPackages = [
      # Useful to avoid doing 'nix shell nixpkgs#sbctl' everytime
      pkgs.sbctl 
    ];
  };
}


{ config, inputs, lib, pkgs, ... }: let
  role = config.role;
  cfg = config.boot.secureBoot;
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Enable lanzaboote, aka enable SecureBoot
  # Will require additional steps
  # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = role != "iso";
        message = "ISOs aren't allowed to use secureBoot!";
      }
    ];

    boot = {
      bootspec.enable = true;

      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };

      # We don't need the normal systemd-boot anymore
      loader.systemd-boot.enable = lib.mkForce false;
      loader.timeout = 0;
    };

    environment.systemPackages = [
      # Useful to avoid doing 'nix shell nixpkgs#sbctl' everytime
      pkgs.sbctl
    ];
  };
}


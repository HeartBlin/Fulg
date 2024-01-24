{ config, lib, pkgs, ... }: let
  cfg = config.modules.programs.virtualisation.waydroid;
in {
  config = lib.mkIf cfg.enable {
    # Persist the folder where waydroid stores it's containers
    environment.persistence."/persist".directories = [
      "/var/lib/waydroid"
    ];

    # nixpkgs.config.packageOverrides = pkgs: {
    #   nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    #     inherit pkgs;
    #   };
    # };

    environment.systemPackages = [
      pkgs.waydroid
      # pkgs.nur.repos.ataraxiasjel.waydroid-script.override 
    ];

    virtualisation = {
      lxd.enable = true;
      waydroid.enable = true;
    };
  };
}
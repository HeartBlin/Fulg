{ inputs, nixpkgs, ... }: let
  sharedArgs = { inherit inputs; };

  modules = ../modules;
  options = ../modules/options;
  packages = ../packages;

  homePath = ../home;
  homePathISO = ../home/iso;

  homeManager = inputs.homeManager.nixosModules.home-manager;

  shared = [
    modules
    options
    packages
  ];

  home = [
    homePath
    homeManager
  ];

  homeISO = [
    homePathISO
    homeManager
  ];
in {
  # First machine, an AMD/NVIDIA laptop
  Mainz = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # Set the hostname to match the nixosSystem name
      { networking.hostName = "Mainz"; }

      # No default packages
      { environment.defaultPackages = []; }

      # Machine-specific config starts in this folder
      ./Mainz
    ] ++ builtins.concatLists [ shared home ]; #TODO machine specific

    specialArgs = sharedArgs;
  };

  # x86_64 ISO for installing NixOS
  Dreadnought = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # Set network name
      { networking.hostName = "Dreadnought"; }

      { environment.defaultPackages = []; }

      { nixpkgs.config.allowBroken = true; }

      # Pull in ISO specific config
      (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")

      ./Dreadnought
    ] ++ builtins.concatLists [ shared homeISO ];

    specialArgs = sharedArgs;
  };
}

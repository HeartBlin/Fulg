{ inputs, nixpkgs, ... }: let
  sharedArgs = { inherit inputs; };

  config = ../modules/config;
  options = ../modules/options;
  packages = ../packages;

  homePath = ../home;
  homeManager = inputs.homeManager.nixosModules.home-manager;

  shared = [
    config
    options
    packages
  ];

  home = [
    homePath
    homeManager
  ];
in {
  # Main machine, an AMD/NVIDIA laptop
  Gevurah = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # Set the hostname to match the nixosSystem name
      { networking.hostName = "Gevurah"; }

      # No default packages
      { environment.defaultPackages = []; }

      # Machine-specific config starts in this folder
      ./Gevurah
    ] ++ builtins.concatLists [ shared home ];

    specialArgs = sharedArgs;
  };
}

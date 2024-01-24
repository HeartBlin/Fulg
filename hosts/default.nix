{ inputs, nixpkgs, ... }: let
  sharedArgs = { inherit inputs; };

  modules = ../modules;
  options = ../modules/options;

  homePath = ../home;
  homeManager = inputs.homeManager.nixosModules.home-manager;

  shared = [
    modules
    options
  ];

  home = [
    homePath
    homeManager
  ];
in {
  # First machine, an AMD/NVIDIA laptop
  Mainz = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      # Set the hostname to match the nixosSystem name
      { networking.hostName = "Mainz"; }

      # Machine-specific config starts in this folder
      ./Mainz
    ] ++ builtins.concatLists [ shared home ]; #TODO machine specific

    specialArgs = sharedArgs;
  };
}
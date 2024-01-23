{ inputs, nixpkgs, ... }: let
  sharedArgs = { inherit inputs; };

  modules = ../modules;
  options = ../modules/options;

  shared = [
    modules
    options
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
    ] ++ builtins.concatLists [ shared ]; #TODO machine specific

    specialArgs = sharedArgs;
  };
}
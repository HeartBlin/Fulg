{
  description = ''
    HeartBlin's flake-based NixOS setup
    It is unstable as f@#$ most likely
  '';

  inputs = {
    # I like unstable packages, switch to stable if you like
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Secureboot
    lanzaboote.url = "github:nix-community/lanzaboote/v0.3.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... }@inputs: {
    # Go to ./hosts/default.nix to see the rest
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs;
    };
  };
}
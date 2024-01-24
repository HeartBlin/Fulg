{
  description = ''
    HeartBlin's flake-based NixOS setup
    It is unstable as f@#$ most likely
  '';

  inputs = {
    # I like unstable packages, switch to stable if you like
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Firefox addons
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    # Firefox GNOME Theme
    firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme";
    firefox-gnome-theme.flake = false;

    # wlroots based compositor 
    hyprland.url = "github:hyprwm/Hyprland";

    # Manage '/home'
    homeManager.url = "github:nix-community/home-manager";
    homeManager.inputs.nixpkgs.follows = "nixpkgs";

    # Allow us to persist folders
    impermanence.url = "github:nix-community/impermanence";

    # Secureboot
    lanzaboote.url = "github:nix-community/lanzaboote/v0.3.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    # Nix helper
    nh.url = "github:viperML/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... }@inputs: {
    # Go to ./hosts/default.nix to see the rest
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs;
    };
  };
}
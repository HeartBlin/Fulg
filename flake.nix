{
  description = ''
    HeartBlin's flake-based NixOS setup
    It is unstable as f@#$ most likely
  '';

  inputs = {
    # I like unstable packages, switch to stable if you like
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Aylur's GTK Shell
    ags.url = "github:Aylur/ags";

    # Anyrun
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    # Firefox addons
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    # Firefox GNOME Theme
    firefox-gnome-theme.url = "github:rafaelmardojai/firefox-gnome-theme";
    firefox-gnome-theme.flake = false;

    # Declarative Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    # wlroots based compositor && related
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";

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

    # GE-Proton
    nix-gaming.url = "github:fufexan/nix-gaming";

    # MacOS VM
    nixtheplanet.url = "github:matthewcroughan/nixtheplanet";
  };

  outputs = { nixpkgs, /* chaotic, */ ... }@inputs: {
    # Go to ./hosts/default.nix to see the rest
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs;
    };
  };
}
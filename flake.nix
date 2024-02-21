{
  description = ''
    HeartBlin's flake-based NixOS setup
    It is unstable as f@#$ most likely
  '';

  inputs = {
    # I use unstable for all use-cases
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    # wlroots based compositor && related
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";

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

    # Used to get LL on pipewire
    nix-gaming.url = "github:fufexan/nix-gaming";

    # 'command-not-found' replacement
    nix-index.url = "github:nix-community/nix-index";
  };

  outputs = { nixpkgs, ... }@inputs: {
    # Go to ./hosts/default.nix to see the rest
    nixosConfigurations = import ./hosts {
      inherit (nixpkgs) lib;
      inherit inputs nixpkgs;
    };
  };
}

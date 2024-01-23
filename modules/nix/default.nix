{ pkgs, ... }:

{
  environment = {
    systemPackages = [
      pkgs.git # Flakes need this
    ];
  };

  nix = {
    settings = {
      # Enable flakes
      experimental-features = [ "nix-command" "flakes" "cgroups" ];

      # Accept nix flakes by default
      accept-flake-config = true;

      # Build inside cgroups
      use-cgroups = true;
    };
  };

  # Change this if you know what you are doing
  system.stateVersion = "24.05";
}
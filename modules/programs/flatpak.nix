{ inputs, ... }: let
  
in {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  # Enable Flatpaks
  services.flatpak.enable = true;

  services.flatpak.remotes = [{
    name = "flathub";
    location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
  }];

  #services.flatpak.packages = [
  #  { appId = "dev.vencord.Vesktop"; origin = "flathub"; }
  #  { appId = "im.riot.Riot"; origin = "flathub"; }
  #];
}
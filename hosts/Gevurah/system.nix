{
  config = {
    role = "workstation";
    user.userName = "heartblin";

    boot = {
      graphicalBoot.enable = true;
      secureBoot.enable = true;
    };

    device = {
      cpu = "amd";
      gpu = "nvidia";

      manufacturer = "asus";

      audio.enable = true;
      audio.lowLatency.enable = true;
      bluetooth.enable = true;
    };

    impermanence.enable = true;
    encryption.enable = true;
    gpg.enable = true;

    network.tailscale.enable = true;

    programs = {
      wayland.hyprland.enable = true;

      gaming.steam.enable = true;
      gaming.gamemode.enable = true;
    };
  };
}

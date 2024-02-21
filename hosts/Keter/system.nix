{
  config = {
    role = "server";
    user.userName = "server";

    boot = {
      graphicalBoot.enable = false;
      secureBoot.enable = false;
    };

    device = {
      cpu = "intel";
      gpu = "";

      manufacturer = "";

      audio.enable = false;
      audio.lowLatency.enable = false;
      bluetooth.enable = false;
    };

    impermanence.enable = false;
    encryption.enable = false;
    gpg.enable = false;

    network.tailscale.enable = true;

    programs = {
      wayland.hyprland.enable = false;

      gaming.steam.enable = false;
      gaming.gamemode.enable = false;

      jellyfin.enable = true;
    };
  };
}

{
  config = {
    # NixOS Modules
    modules = {
      boot = {
        secureBoot.enable = false;
        plymouth.enable = false;
      };

      device = {
        # IDK the GPU or CPU of the target PC
        cpu = "-";
        gpu = "-";

        audio.enable = false;
        asus.enable = false;
        bluetooth.enable = false;
      };

      programs = {
        adb.enable = false;
        gamemode.enable = false;
        steam.enable = false;
        transmission.enable = false;

        virtualisation = {
          distrobox.enable = false;
          macos.enable = false;
          waydroid.enable = false;
        };

        wayland.hyprland.enable = false;
      };

      users.userName = "heartblin";

      encryption.enable = false;
      impermanence.enable = false;
    };

    # Home Manager Modules
    home = {
      terminal = "-";

      shell = {
        name = "fish";
        starship.enable = true;
      };

      editors = {
        vscode.enable = false;
        neovim.enable = false;
      };
    };
  };
}

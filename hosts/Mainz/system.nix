{
  config = {
    # NixOS Modules
    modules = {
      boot = {
        secureBoot.enable = true;
        plymouth.enable = true;
      };

      device = {
        cpu = "amd";
        gpu = "nvidia";

        audio.enable = true;
        asus.enable = true;
        bluetooth.enable = true;
        dualboot.enable = true;
      };

      programs = {
        adb.enable = true;
        gamemode.enable = true;
        steam.enable = true;

        virtualisation = {
          distrobox.enable = true;
          macos.enable = false;
          waydroid.enable = true;
        };
        
        wayland.hyprland.enable = true;
      };

      users.userName = "heartblin";
      
      encryption.enable = true;
      impermanence.enable = true;
    };

    # Home Manager Modules
    home = {
      terminal = "foot";

      shell = {
        name = "fish";
        starship.enable = true;
      };

      editors = {
        vscode.enable = true;
        neovim.enable = true;
      };
    };
  };
}
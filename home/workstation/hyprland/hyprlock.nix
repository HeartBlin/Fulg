{ inputs, ... }:

{
  imports = [
    inputs.hypridle.homeManagerModules.default
    inputs.hyprlock.homeManagerModules.default
  ];

  services.hypridle = {
    enable = true;
    listeners = [
      {
        timeout = 300;
        onTimeout = "asusctl -k off && hyprlock";
        onResume = "asusctl -k med";
      }
    ];

    lockCmd = "hyprlock";
    afterSleepCmd = "hyprlock";
  };

  programs.hyprlock = {
    enable = true;
    general = {
      disable_loading_bar = false;
      hide_cursor = true;
    };

    backgrounds =  [
      {
        monitor = "eDP-1";
        path = "/home/heartblin/Pictures/HyprChan.png";
        color = "rgba(25, 25, 25, 1.0)";
      }
    ];

    input-fields = [
      {
        monitor = "eDP-1";
        size.width = 300;
        size.height = 40;
        outline_thickness = 1;
        outer_color = "rgba(64, 64, 64, 1)";
        inner_color = "rgba(25, 25, 25, 0.85)";
        font_color = "rgb(FFFFFF)";
        fade_on_empty = false;
        placeholder_text = "IDK";
        halign = "center";
        valign = "center";
      }
    ];
  };
}

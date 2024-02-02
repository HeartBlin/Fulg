{ configHM, pkgs, ... }:
let
  hyprshot = pkgs.writeShellScriptBin "hyprshot" ''
    #!/bin/bash
    hyprctl keyword animation "fadeOut,0,8,slow" && ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -w 0 -b 000000AA)" - | swappy -f -; hyprctl keyword animation "fadeOut,1,8,slow"
  '';
in {
  home.packages = [
    hyprshot
    pkgs.swappy
    pkgs.wl-color-picker
  ];

  wayland.windowManager.hyprland = {
    enable = configHM.modules.programs.wayland.hyprland.enable;

    settings = {
      "$MOD" = "SUPER";

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
      ];

      monitor = [
        "eDP-1, 1920x1080@144, 0x0, 1"
        "HDMI-A-1, 1920x1080@60, auto, 1, mirror, eDP-1"
      ];

      exec-once = [
        # Core
        "dbus-update-activation-environment --all &"
        "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # In case services crash ffs
        "systemctl restart --user hyprpaper wl-clip-persist cliphist"
      ];

      general = {
        max_fps = 144;
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;

        "col.active_border" = "rgb(2F2F2F)";
        "col.inactive_border" = "rgb(2F2F2F)";

        layout = "dwindle";
      };

      dwindle = {
	      preserve_split = true;
	      # no_gaps_when_only = true;
      };

      decoration = {
        rounding = 15;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = "on";

          size = 7;
          passes = 4;
          brightness = 1;
          noise = 0.01;
          contrast = 1;
        };

        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_range = 15;
        shadow_offset = "0 2";
        shadow_render_power = 6;
        "col.shadow" = "rgba(00000044)";
      };

      animations = {
        enabled = true;
        # Curves
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        # Animations
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      input = {
        kb_layout = "ro";
        follow_mouse = 1;

        numlock_by_default = true;
        touchpad = {
          natural_scroll = "no";
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.7;
        };
        scroll_method = "2fg";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        disable_autoreload = true;
      };

      bind = [
        "$MOD SHIFT, E, exit" # Exit Hyprland

        # Programs
        "$MOD, W, exec, ${pkgs.firefox}/bin/firefox"
        "$MOD SHIFT, W, exec, ${pkgs.microsoft-edge}/bin/microsoft-edge"
        "$MOD, RETURN, exec, ${pkgs.foot}/bin/foot"
        "$MOD, SPACE, exec, ${pkgs.rofi}/bin/rofi -show drun"
        "$MOD, C, exec, ${pkgs.vscode}/bin/code"
        "CONTROL SHIFT, ESCAPE, exec, ${pkgs.mission-center}/bin/missioncenter"

        # Window operations
        "$MOD, Q, killactive" # Kill active window
        "$MOD SHIFT, F, togglefloating" # Float active window
        "$MOD, F, fullscreen" # Fullscreen active window

        # Screenshot
        ",PRINT, exec, hyprshot"

        # Workspace operations
        "$MOD, 1, workspace, 1"
        "$MOD, 2, workspace, 2"
        "$MOD, 3, workspace, 3"
        "$MOD, 4, workspace, 4"
        "$MOD, 5, workspace, 5"
        "$MOD, 6, workspace, 6"
        "$MOD, 7, workspace, 7"
        "$MOD, 8, workspace, 8"
        "$MOD, 9, workspace, 9"
        "$MOD, 0, workspace, 10"

        "$MOD SHIFT, 1, movetoworkspace, 1"
        "$MOD SHIFT, 2, movetoworkspace, 2"
        "$MOD SHIFT, 3, movetoworkspace, 3"
        "$MOD SHIFT, 4, movetoworkspace, 4"
        "$MOD SHIFT, 5, movetoworkspace, 5"
        "$MOD SHIFT, 6, movetoworkspace, 6"
        "$MOD SHIFT, 7, movetoworkspace, 7"
        "$MOD SHIFT, 8, movetoworkspace, 8"
        "$MOD SHIFT, 9, movetoworkspace, 9"
        "$MOD SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];

      binde = [
        # volume controls
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # brightness controls
        ",XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
        ",XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
        ",XF86KbdBrightnessUp, exec, asusctl -n"
        ",XF86KbdBrightnessDown, exec, asusctl -p"
      ];

      bindl = [
        # Media controls
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPrev,exec,playerctl previous"
        ",XF86AudioNext,exec,playerctl next"
      ];

      windowrulev2 = [
        # Always fullscreen Waydroid
        "fullscreen, class:^(Waydroid)(.*)$"
        "fullscreen, class:^(waydroid)(.*)$"

        # Window mission-center
        "float, class:io.missioncenter.MissionCenter"
        "size 975 850, class:io.missioncenter.MissionCenter"
        "move 20 20, class:io.missioncenter.MissionCenter"

        # Dialogs
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$ "
      ];
    };
  };
}
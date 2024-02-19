{ config, lib, pkgs, ... }: let
  programs = lib.makeBinPath [
    config.programs.hyprland.package
    pkgs.coreutils
  ];

  startscript = pkgs.writeShellScript "gamemode-start" ''
    export PATH=$PATH:${programs}
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | head -1)
    hyprctl --batch 'keyword decoration:blur:enabled 0 ; keyword animations:enabled 0 ; keyword misc:vfr 0'
  '';

  endscript = pkgs.writeShellScript "gamemode-end" ''
    export PATH=$PATH:${programs}
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | head -1)
    hyprctl --batch 'keyword decoration:blur:enabled 1 ; keyword animations:enabled 1 ; keyword misc:vfr 1'
  '';

  cfg = config.programs;
in {
  config = lib.mkIf ( cfg.gaming.gamemode.enable && cfg.wayland.hyprland.enable ){
    programs.gamemode = {
      # Turn off some expansive Hyprland options
      settings.custom.start = startscript.outPath;
      settings.custom.end = endscript.outPath;
    };
  };
}

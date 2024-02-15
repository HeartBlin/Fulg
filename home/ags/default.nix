{ config, inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = [
    pkgs.segoe-fluent-icons
    pkgs.segoe-ui-variable
    pkgs.sassc
    pkgs.inotify-tools.out
  ];

  programs.ags = {
    enable = true;
  };

  home.file.".config/ags" = {
    source = ./data;
    recursive = true;
    enable = true;
  };
}

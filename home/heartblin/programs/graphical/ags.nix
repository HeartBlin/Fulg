{ inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = [
    pkgs.segoe-fluent-icons
    pkgs.segoe-ui-variable
  ];

  programs.ags = {
    enable = true;
  };
}
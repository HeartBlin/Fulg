{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      starship init fish | source
      eval "$(ssh-agent -c)" >/dev/null
    '';

    shellAbbrs = {
      # Manage nix
      switch = "clear && nh os switch";
      boot = "clear && nh os switch";
      up = "clear && nix flake update --flake ~/Documents/Fulg/ && clear && nh os switch";
      garbage = "clear && nh clean all";

      # Go to dotfile folder
      dots = "cd $HOME/Documents/Fulg";

      # Utils
      cat = "${pkgs.bat}/bin/bat -p";
      grep = "${pkgs.ripgrep}/bin/rg -p";
      ls = "${pkgs.eza}/bin/eza -l -h --icons";

      # Archival
      tarnow = "tar -acf";
      untar = "tar -xcf";

      # systemd
      errors = "journalctl -p 3 -xb";
    };
  };
}
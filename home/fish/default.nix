{ configHM, lib, pkgs, ... }: let
  cfg = configHM.home;
in {
  config = lib.mkIf ( cfg.shell.name == "fish" ) {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        eval "$(ssh-agent -c)" >/dev/null
      '';

      ##starship init fish | source
      shellAbbrs = {
        # Manage nix
        switch = "clear && nh os switch";
        boot = "clear && nh os switch";
        up = "clear && nix flake update ~/Documents/Fulg/ && clear && nh os switch";
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
  };
}
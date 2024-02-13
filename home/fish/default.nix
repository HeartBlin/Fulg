{ configHM, lib, pkgs, ... }: let
  cfg = configHM.home;
in {
  config = lib.mkIf ( cfg.shell.name == "fish" ) {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        set -x SHELL ${pkgs.fish}/bin/fish
        set -x EDITOR nvim

        eval "$(ssh-agent -c)" >/dev/null
      '';

      shellAliases = {
        # Manage 'nix' commands
        rebuild = "clear && nh os switch";
        boot = "clear && nh os switch";
        up = "clear && nix flake update ~/Documents/Fulg/ && clear && nh os switch";
        garbage = "clear && nh clean all";

        # Replace default tools with nicer ones
        ls = "${pkgs.eza}/bin/eza -l --color=always --group-directories-first --icons";
        la = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first --icons";
        cat = "${pkgs.bat}/bin/bat --style header --style snip --style changes --style header";
        grep = "${pkgs.ripgrep}/bin/ripgrep";
        mv = "mv -iv";
        rm = "rm -iv";

        # Git specific
        g = "git";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gs = "git status";

        # Go to dotfile folder
        dots = "cd $HOME/Documents/Fulg";

        # Archival
        tarnow = "tar -acf";
        untar = "tar -zxcf";

        # systemd
        errors = "journalctl -p 3 -xb";
      };
    };

    home.packages = [
      (pkgs.nerdfonts.override {
        fonts = [ "FiraCode" ];
      })
    ];
  };
}

{ pkgs, ... }: let
  command-not-found = pkgs.writeShellScriptBin "command-not-found" ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    command_not_found_handle "$@"
  '';
in {
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
      up = "clear && nix flake update /etc/nixos && clear && nh os switch";
      garbage = "clear && nh clean all";

      # Replace default tools with nicer ones
      ls = "${pkgs.eza}/bin/eza -l --color=always --group-directories-first --icons";
      la = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first --icons";
      cat = "${pkgs.bat}/bin/bat --style header --style snip --style changes --style header";
      grep = "${pkgs.ripgrep}/bin/rg";
      mv = "mv -iv";
      rm = "rm -iv";

      # Git specific
      g = "git";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gs = "git status";

      # Go to dotfile folder
      dots = "cd /etc/nixos";

      # Archival
      tarnow = "tar -acf";
      untar = "tar -zxcf";

      # systemd
      errors = "journalctl -p 3 -xb";
    };

    functions = {
      __fish_command_not_found_handler = {
        body = "${command-not-found}/bin/command-not-found $argv";
        onEvent = "fish_command_not_found";
      };
    };
  };

  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];
}

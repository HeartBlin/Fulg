{ pkgs, ... }: 

{
  home.packages = [
    pkgs.monaspace
  ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        shell = "fish";
        term = "xterm-256color";
        title = "foot";

        pad = "25x25";

        font = "Monaspace Krypton:size=13";
        letter-spacing = 0;
        bold-text-in-bright = "no";
      };

      colors = {
        alpha = 0.9;
        background = "1d1f21";
        foreground = "eaeaea";

        regular0 = "1d1f21";
        regular1 = "d54e53";
        regular2 = "b9ca4a";
        regular3 = "e7c547";
        regular4 = "7aa6da";
        regular5 = "c397d8";
        regular6 = "70c0b1";
        regular7 = "c5c8c6";

        bright0 = "666666";
        bright1 = "cc6666";
        bright2 = "b5bd68";
        bright3 = "f0c674";
        bright4 = "81a2be";
        bright5 = "b294bb";
        bright6 = "8abeb7";
        bright7 = "eaeaea";
      };

      key-bindings = {
        search-start = "Control+f";
      };
    };
  };
}
{ inputs, pkgs, ... }:

{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
      ];
      width.fraction = 0.3;
      y.fraction = 0.4;
      x.fraction = 0.5;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = ''
      * {
        transition: 200ms ease;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      box#main {
        background: #282828;
      }
    '';

    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: false,
        max_entries: 5,
        terminal: Some("foot")
      )
    '';
  };
}

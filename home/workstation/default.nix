{ config, inputs, lib, ... }: let
  role = config.role;
  user = config.user;
  configHM = config;
in {
  config = lib.mkIf ( role == "workstation") {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs configHM; };
      users.${user.userName} = {
        # Import all the files
        imports = [
          ## GUI
          # Wayland Bar - AGS
          ./ags

          # Wayland App Launcher - Anyrun
          ./anyrun

          # Vesktop - Discord client
          ./vesktop

          # MS-Edge
          ./edge

          # Firefox
          ./firefox

          # Hyprland + related
          ./hyprland

          # Nautilus
          ./nautilus

          # OnlyOffice
          ./onlyoffice

          # VSCode
          ./vscode

          # Wayland Clipboard
          ./clipboard

          # GTK
          ./gtk

          ## CLI
          # Terminal(s)
          ./foot

          # Shell(s) + related
          ./fish
          ./starship

          # Version Control
          ./git

          # OpenSSH
          ./ssh
        ];

        programs.home-manager.enable = true;
        home.stateVersion = "23.11";
      };
    };
  };
}

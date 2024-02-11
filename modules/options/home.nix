{ lib, ... }:

{
  options.home = {
    # Set prefered terminal
    terminal = lib.mkOption { type = lib.types.str; };

    
    shell = {
      # Set prefered shell
      name = lib.mkOption { type = lib.types.str; };

      # Enable starship
      starship.enable = lib.mkEnableOption "Enables Starship prompt";
    };

    editors = {
      # Enable VSCode
      vscode.enable = lib.mkEnableOption "Enables VSCode IDE";

      # Enable Neovim + nixvim
      neovim.enable = lib.mkEnableOption "Enables nvim CLI editor";
    };
  };
}
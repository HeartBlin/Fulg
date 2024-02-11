{ lib, ... }:

{
  options.home = {
    # Set prefered terminal
    terminal = lib.mkOption { type = lib.types.str; };

    
    shell = {
      # Set prefered shell
      name = lib.mkOption { type = lib.types.str; };

      # Enable starship
      starship = lib.mkEnableOption "Enables Starship prompt";
    };
  };
}
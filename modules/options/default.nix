# I will comment only the 'lib.mkOption' options
# as 'lib.mkEnableOption' explains itself

{ lib, ... }:

{
  options = {
    modules = {
      users = {
        # Set the username of the system
        userName = lib.mkOption { type = lib.types.str; };
      };

      boot = {  
        secureBoot = lib.mkEnableOption "Enable SecureBoot support";
      };
    };
  };
}
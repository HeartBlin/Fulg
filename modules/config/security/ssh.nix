{ config, lib, ... }: let
  role = config.role;
in {
  config = lib.mkIf ( role == "server" ) {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
  };
}

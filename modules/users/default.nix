# Add users or change user name through the system
# PS: Do not hardcode usernames

{ config, lib, ... }: let
  cfg = config.modules.users;
in {
  # Make the user 'heartblin'
  config = lib.mkIf ( cfg.userName == "heartblin") {
    users.users."${cfg.userName}" = {
      isNormalUser = true;
      initialPassword = "changeme";
      extraGroups = [ "wheel" "video" ];
    };
  };

  # TODO: In the future add more if needed
}
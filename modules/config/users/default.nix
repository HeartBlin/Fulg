# Add users or change user name through the system
# PS: Do not hardcode usernames

{ config, lib, ... }: let
  user = config.user;
in {
  # Make the user 'heartblin'
  config = lib.mkIf ( user.userName == "heartblin") {
    users.users."${user.userName}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "video" ];
    };
  };
}

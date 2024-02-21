{ config, lib, ... }: let
  role = config.role;
in {
  # Make the user 'heartblin'
  users.users."heartblin" = lib.mkIf ( role == "workstation") {
    isNormalUser = true;
    description = "HeartBlin";
    extraGroups = [ "wheel" "video" ];
  };

  # Make the user for the server
  users.users."server" = lib.mkIf ( role == "server") {
    isNormalUser = true;
    description = "Server";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJR590NCThXFKZ1dnVUgMmndhUecJwHqqti5mVoZ8X2p heartblin@Mainz"
    ];
  };
}

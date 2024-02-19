{ ... }:

{
  # Enable systemd-boot for all roles
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  imports = [
    ./lanzaboote.nix
    ./plymouth.nix
  ];
}

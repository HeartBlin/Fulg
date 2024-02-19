{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.tailscale
  ];

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
}

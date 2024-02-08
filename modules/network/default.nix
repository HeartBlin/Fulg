# This file is included in all systems that access modules
# It does not have any option asociated

{ lib, ... }:

{
  networking = {
    # Please keep my WiFi card name the same ffs
    usePredictableInterfaceNames = true;

    useDHCP = false;
    useNetworkd = true;

    # Cli mostly
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";

      ethernet.macAddress = "random";

      wifi = {
        macAddress = "random";
        scanRandMacAddress = true;
        powersave = false;
      };
    };

    # Firewall
    firewall.enable = true;

    # DNS
    nameservers = [
      # Quad9
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"

      # Cloudflare
      #"1.1.1.1"
      #"1.0.0.1"
      #"2606:4700:4700::1111" 
      #"2606:4700:4700::1001"
    ];
  };

  # Set up systemd-resolved
  services.resolved = {
    enable = true;
    fallbackDns = [ "9.9.9.9" ]; 
    dnssec = "false"; # MITM lmao
    domains = [ "~." ];
    extraConfig = "DNSOverTLS=yes";
  };

  ## Optimisations ##
  systemd = {
    network.wait-online.enable = lib.mkForce false;
    services = {
      NetworkManager-wait-online.enable = lib.mkForce false;
      systemd-networkd.stopIfChanged = lib.mkForce false;
      systemd-resolved.stopIfChanged = lib.mkForce false;
    };
  };
}
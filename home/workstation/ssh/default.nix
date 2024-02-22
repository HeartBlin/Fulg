{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "Keter" = {
        hostname = "192.168.0.124"; # Reserved
        user = "server";
        identityFile = "~/.ssh/Keter";
      };
    };
  };
}

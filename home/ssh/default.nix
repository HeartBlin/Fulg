{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "Midway" = {
        hostname = "192.168.0.68"; # Reserved
        user = "server";
        identityFile = "~/.ssh/Midway";
      };
    };
  };
}

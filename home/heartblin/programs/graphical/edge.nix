{ pkgs, ... }:

{
  # It's actually MS-Edge lmao
  programs.chromium = {
    enable = true;
    package = pkgs.microsoft-edge-dev;

  };
}
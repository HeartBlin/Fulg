{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userEmail = "heartblin@proton.me";
      userName = "HeartBlin";
      signing = {
        key = "0xE7915D7BAA8DEFCB";
        signByDefault = true;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = false;
      extensions = [
        pkgs.gh-dash
        pkgs.gh-eco
        pkgs.gh-cal
      ];
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}

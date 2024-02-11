{ configHM, inputs, lib, ... }: let
  cfg = configHM.home.editors.neovim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      enableMan = false;
      ## TODO
    };
  };
}
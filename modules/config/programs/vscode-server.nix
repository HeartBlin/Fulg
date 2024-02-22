{ config, inputs, lib, pkgs, ... }: let
  role = config.role;
  cfg = config.programs.vscodeServer;
in {
  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = role != "workstation";
        message = "Workstations aren't allowed to host VSCode instances!";
      }
      {
        assertion = role != "iso";
        message = "ISOs can't host VSCode instances!";
      }
    ];

    services.vscode-server.enable = true;
    services.vscode-server.enableFHS = true;
    services.vscode-server.nodejsPackage = pkgs.nodejs_21;
  };
}

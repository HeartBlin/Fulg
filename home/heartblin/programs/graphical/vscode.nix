{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    userSettings = {
      "window.titleBarStyle" = "custom";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.colorTheme" = "Visual Studio Dark";

      # Use 'nil' as the Nix language server
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";

      # Allow gpg signing
      "git.enableCommitSigning" = true;
    };

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-vscode.cpptools
      pkief.material-icon-theme
    ];
  };

  home.packages = [
    pkgs.nil
  ];
}
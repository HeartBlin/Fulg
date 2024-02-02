{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    userSettings = {
      "window.titleBarStyle" = "custom";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.colorTheme" = "Visual Studio Dark";

      "editor.fontFamily" = "'Cascadia Code', monospace";
      "editor.fontLigatures" = true;

      # Use 'fish' as the shell
      "terminal.integrated.defaultProfile.linux" = "fish";

      # Use 'nil' as the Nix language server
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";

      # Allow gpg signing
      "git.enableCommitSigning" = true;

      # General settings
      "editor.accessibilitySupport" = "off";
      "explorer.compactFolders" = false;
      "workbench.tree.renderIndentGuides" = "always";
      "editor.bracketPairColorization.enabled" = true;
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    };

    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-vscode.cpptools
      pkief.material-icon-theme
      eamodio.gitlens
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # Add extensions here
    ];
  };

  home.packages = [
    pkgs.nil
    pkgs.statix
  ];
}
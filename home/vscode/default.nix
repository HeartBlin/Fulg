{ configHM, lib, pkgs, ... }: let
  cfg = configHM.home.editors.vscode;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      userSettings = {
        "window.titleBarStyle" = "custom";
        "workbench.iconTheme" = "material-icon-theme";

        "editor.fontFamily" = "'Cascadia Code', monospace";
        "editor.tokenColorCustomizations" = {
          "textMateRules" = [
            {
              "scope" = [
                "comment"
                "entity.name.type.class"
                "keyword"
                "constant"
                "storage.type"
                "variable.language.this.cpp"
              ];
              "settings" = {
                "fontStyle" = "bold";
              };
            }
          ];
        };

        # Use 'fish' as the shell
        "terminal.integrated.defaultProfile.linux" = "fish";

        # Use 'nil' as the Nix language server
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";

        # Allow gpg signing
        "git.enableCommitSigning" = true;

        # General settings
        "editor.accessibilitySupport" = "off";
        "explorer.compactFolders" = true;
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
        # Monokai Pro Theme
        {
          name = "theme-monokai-pro-vscode";
          publisher = "monokai";
          version = "1.2.2";
          sha256 = "sha256-xeLzzNgj/GmNnSmrwSfJW6i93++HO3MPAj8RwZzwzR4=";
        }
      ];
    };

    home.packages = [
      pkgs.cascadia-code
      pkgs.nil
      pkgs.statix
    ];
  };
}
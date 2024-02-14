### Most 'userSettings' are from rxyhn on GitHub ###
### https://github.com/rxyhn/yuki/tree/main/home/modules/programs/vscode ###

{ configHM, lib, pkgs, ... }: let
  cfg = configHM.home.editors.vscode;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      userSettings = {
        # Disable autoUpdates
        "extensions.autoCheckUpdates" = false;
        "extensions.ignoreRecommendations" = true;
        "update.mode" = "none";

        # Editor
        "editor.bracketPairColorization.enabled" = true;
        "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorStyle" = "line";
        "editor.cursorSurroundingLines" = 15;
        "editor.fontFamily" = "'Cascadia Code', monospace";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 15;
        "editor.fontWeight" = 500;
        "editor.guides.bracketPairs" = true;
        "editor.guides.indentation" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.enabled" = false;
        "editor.renderLineHighlight" = "all";
        "editor.semanticHighlighting.enabled" = true;
        "editor.showUnused" = true;
        "editor.smoothScrolling" = true;
        "editor.trimAutoWhitespace" = true;

        # Explorer
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;

        # Files
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;

        # Terminal
        "terminal.integrated.defaultProfile.linux" = "fish";
        "terminal.integrated.smoothScrolling" = true;

        # Window
        "window.autoDetectColorScheme" = true;
        "window.dialogStyle" = "custom";
        "window.menuBarVisibility" = "toggle";
        "window.titleBarStyle" = "custom";

        # Workbench
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.panel.defaultLocation" = "right";
        "workbench.sideBar.location" = "right";

        ## Extensions
        "git.autofetch" = true;
        "git.enableCommitSigning" = true;
        "git.enableSmartCommit" = true;

        "path-intellisense.autoSlashAfterDirectory" = true;
        "path-intellisense.autoTriggerNextSuggestion" = true;
        "path-intellisense.extensionOnImport" = true;
        "path-intellisense.showHiddenFiles" = true;

        ## Language Specific
        # Java
        "java.configuration.runtimes" = [
          {
            name = "JavaSE-17";
            path = "${pkgs.jdk17}/lib/openjdk";
            default = true;
          }
        ];
        "java.format.settings.profile" = "GoogleStyle";
        "java.jdt.ls.java.home" = "${pkgs.jdk17}/lib/openjdk";

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings"."nil"."formatting"."command" = [ "${pkgs.alejandra}/bin/alejandra" ];
      };

      mutableExtensionsDir = false;
      extensions = (with pkgs.vscode-extensions; [
        christian-kohler.path-intellisense
        redhat.java
        jnoortheen.nix-ide
        ms-vscode.cpptools
        pkief.material-icon-theme
      ]);
    };

    xdg.mimeApps.defaultApplications."text/plain" = "code.desktop";

    home.packages = [
      pkgs.cascadia-code
    ];
  };
}

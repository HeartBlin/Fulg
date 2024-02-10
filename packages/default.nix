_: {
  # Imports all my custom packages
  nixpkgs.overlays = [
    (final: prev: {
      #

      # Fonts
      monaspace = final.callPackage ./fonts/monaspace.nix {};
      segoe-ui-variable = final.callPackage ./fonts/segoe-ui-variable.nix {};
      segoe-fluent-icons = final.callPackage ./fonts/segoe-fluent-icons.nix {};
    })
  ];
}
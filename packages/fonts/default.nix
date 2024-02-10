{ pkgs, ... }:

{
  fonts.packages = [
    pkgs.cascadia-code
    (pkgs.callPackage ./monaspace.nix {})
    (pkgs.callPackage ./segoe-ui-variable.nix {})
    (pkgs.callPackage ./segoe-fluent-icons.nix {})

    pkgs.dejavu_fonts
    pkgs.kochi-substitute
  ];

  i18n.inputMethod.enabled = "fcitx5";
}
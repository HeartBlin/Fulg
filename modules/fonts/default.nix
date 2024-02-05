{ pkgs, ... }:

{
  fonts.packages = [
    pkgs.cascadia-code
    (pkgs.callPackage ./monaspace.nix {})

    pkgs.dejavu_fonts
    pkgs.kochi-substitute
  ];

  i18n.inputMethod.enabled = "fcitx5";
}
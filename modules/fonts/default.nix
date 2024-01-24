{ pkgs, ... }:

{
  fonts.packages = [
    pkgs.cascadia-code
    (pkgs.callPackage ./monaspace.nix {})
  ];
}
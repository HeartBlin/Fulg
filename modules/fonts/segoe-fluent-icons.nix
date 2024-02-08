{ lib, pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "Segoe-Fluent-Icons";
  version = "1";

  src = pkgs.fetchzip {
    url = "https://download.microsoft.com/download/8/f/c/8fc7cbc3-177e-4a22-af48-2a85e1c5bffb/Segoe-Fluent-Icons.zip";
    hash = "sha256-MgwkgbVN8vZdZAFwG+CVYu5igkzNcg4DKLInOL1ES9A=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts/segoe-fluent-icons
    cp -R $src $out/share/fonts/segoe-fluent-icons
  '';

  meta = {
    description = "Fonts used in Windows app design";
    homepage = "https://learn.microsoft.com/en-us/windows/apps/design/downloads/#tools";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all; # They're fonts ffs
    maintainers = with lib.maintainers; [ HeartBlin ];
  };
}
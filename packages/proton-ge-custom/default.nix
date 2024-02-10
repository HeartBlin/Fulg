{ stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation rec {
  pname = "proton-ge-custom";
  version = "GE-Proton8-31";

  # Get the tar.gz file
  src = fetchurl {
    url = "https://github.com/GloriousEggroll/${pname}/releases/download/${version}/${version}.tar.gz";
    hash = "sha256-ogxZmso7F0q+VB7/NYTvIiqPt5OCxkoAXhtvNr6KVC4=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    tar -C $out/bin --strip=1 -xf $src
    runHook postInstall
  '';
}
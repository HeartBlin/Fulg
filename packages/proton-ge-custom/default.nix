{ stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation rec {
  pname = "proton-ge-custom";
  version = "GE-Proton8-32";

  # Get the tar.gz file
  src = fetchurl {
    url = "https://github.com/GloriousEggroll/${pname}/releases/download/${version}/${version}.tar.gz";
    hash = "sha256-U+5CvBVWCFQRMtb7+KcaHx9Coj7cXg5V0EJd+e51PaA=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    tar -C $out/bin --strip=1 -xf $src
    runHook postInstall
  '';
}

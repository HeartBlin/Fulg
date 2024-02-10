{ stdenvNoCC, fetchzip, lib }:

stdenvNoCC.mkDerivation rec {
  pname = "monaspace";
  version = "1.000";

  src = fetchzip {
    url = "https://github.com/githubnext/${pname}/releases/download/v${version}/${pname}-v${version}.zip";
    hash = "sha256-H8NOS+pVkrY9DofuJhPR2OlzkF4fMdmP2zfDBfrk83A=";
    stripRoot=false;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/monaspace
    cp -R $src $out/share/fonts/monaspace
    runHook postInstall
  '';

  meta = {
    description = "An innovative superfamily of fonts for code";
    homepage = "https://monaspace.githubnext.com/";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all; # They're fonts ffs
    maintainers = with lib.maintainers; [ HeartBlin ];
  };
}
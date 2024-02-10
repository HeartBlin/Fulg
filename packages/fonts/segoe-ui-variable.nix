{ stdenvNoCC, fetchzip, lib }:

stdenvNoCC.mkDerivation {
  pname = "SegoeUI-VF";
  version = "1";

  src = fetchzip {
    url = "https://download.microsoft.com/download/f/5/9/f5908651-3551-4a00-b8a0-1b46b5feb723/SegoeUI-VF.zip";
    hash = "sha256-s82pbi3DQzcV9uP1bySzp9yKyPGkmJ9/m1Q6FRFfGxg=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/segoeUI
    cp -R $src $out/share/fonts/segoeUI
    runHook postInstall
  '';

  meta = {
    description = "Fonts used in Windows app design";
    homepage = "https://learn.microsoft.com/en-us/windows/apps/design/downloads/#tools";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all; # They're fonts ffs
    maintainers = with lib.maintainers; [ HeartBlin ];
  };
}
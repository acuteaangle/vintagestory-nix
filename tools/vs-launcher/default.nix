{ lib
, stdenvNoCC
, appimageTools
, fetchurl
}: let
  pname = "vs-launcher";
  version = "1.3.2";

  appImageSrc = fetchurl {
    url = "https://github.com/XurxoMF/vs-launcher/releases/download/${version}/vs-launcher-${version}.AppImage";
    sha256 = "sha256-vq/j8LsZiyDQs3V6hNaG4Qhf0jvTQROGSaF2wBYMjT0=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version;
    src = appImageSrc;
  };
in stdenvNoCC.mkDerivation rec {
  inherit pname version;

  src = appimageTools.wrapType2 {
    inherit pname version;
    src = appImageSrc;
    profile=''
      export APPIMAGE=true
    '';
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r $src/bin $out

    mkdir -p $out/share/applications
    cp -r ${appimageContents}/usr/share/icons $out/share
    cp ${appimageContents}/${pname}.desktop $out/share/applications
    sed -i 's/^Exec=AppRun.*/Exec=${pname}/' $out/share/applications/${pname}.desktop

    runHook postInstall
  '';

  meta = with lib; {
    description = "Unofficial launcher and version manager for Vintage Story";
    homepage = "https://github.com/XurxoMF/vs-launcher";
    downloadPage = "https://github.com/XurxoMF/vs-launcher/releases";
    license = licenses.unfree;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}

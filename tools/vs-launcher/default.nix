{ lib
, buildNpmPackage
, fetchFromGitHub
, copyDesktopItems
, makeDesktopItem
, makeWrapper
, electron
}: buildNpmPackage rec {
  pname = "vs-launcher";
  version = "1.5.4";

  # https://github.com/XurxoMF/vs-launcher.git
  # npm i --package-lock-only
  src = fetchFromGitHub {
    owner = "XurxoMF";
    repo = "vs-launcher";
    rev = version;
    hash = "sha256-+4ZaP6KokKDMqnEleDIqxkgo0soT2Onrvuk3A+vaEXM=";
  };

  npmDepsHash = "sha256-vufwc3B4Xy/oZZ/CIgCnD+Jdr2szoYVbAGtyyaRUXR8=";

  nativeBuildInputs = [
    copyDesktopItems
    makeWrapper
  ];

  env.ELECTRON_SKIP_BINARY_DOWNLOAD = 1;

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  postBuild = ''
    cp -r ${electron.dist} electron-dist
    chmod -R u+w electron-dist

    npm exec electron-builder -- \
        --linux \
        --dir \
        -c.electronDist=electron-dist \
        -c.electronVersion=${electron.version}
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/vs-launcher
    cp -r dist/linux-unpacked/* $out/share/vs-launcher

    install -Dm644 $out/share/vs-launcher/resources/app.asar.unpacked/resources/icon.png $out/share/icons/hicolor/512x512/apps/vs-launcher.png

    makeWrapper ${electron}/bin/electron $out/bin/vs-launcher \
      --add-flags $out/share/vs-launcher/resources/app.asar

    runHook postInstall
  '';

  desktopItems = [(makeDesktopItem {
    name = "vs-launcher";
    desktopName = "VS Launcher";
    exec = "vs-launcher %U";
    icon = "vs-launcher";
    genericName = "Vintage Story Mod Manager";
    comment = meta.description;
    keywords = [
      "launcher"
      "electron"
      "vintage"
      "mods"
    ];
    categories = [
      "Application"
      "Utility"
      "Game"
    ];
  })];

  meta = with lib; {
    description = "Unofficial launcher and version manager for Vintage Story";
    homepage = "https://github.com/XurxoMF/vs-launcher";
    downloadPage = "https://github.com/XurxoMF/vs-launcher/releases";
    license = licenses.unfree;
    platforms = lib.platforms.all;
    mainProgram = pname;
  };
}

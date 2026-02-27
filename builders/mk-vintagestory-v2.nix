{
  lib,
  stdenv,
  fetchzip,
  makeWrapper,
  makeDesktopItem,
  copyDesktopItems,
  cairo,
  libGLU,
  libglvnd,
  pipewire,
  libpulseaudio,
  dotnet-runtime_8,
  x11Support ? true,
  xorg ? null,
  waylandSupport ? false,
  wayland ? null,
  libxkbcommon ? null,
  version,
  hash,
  unstable ? null,
}:

assert x11Support || waylandSupport;
assert x11Support -> xorg != null;
assert waylandSupport -> wayland != null;
assert waylandSupport -> libxkbcommon != null;

stdenv.mkDerivation (finalAttrs: {
  pname = "vintagestory";
  inherit version;

  src =
    let
      checkAssertWarnIf =
        cond: assertions: warnings: val:
        if cond then lib.asserts.checkAssertWarn assertions warnings val else val;
      stability_unchecked = (
        if builtins.length (builtins.splitVersion version) < 4 then
          "stable"
        else if builtins.elemAt (builtins.splitVersion version) 3 == "pre" then
          "pre"
        else
          "unstable"
      );
      stability =
        checkAssertWarnIf (unstable != null)
          [
            {
              assertion = if unstable then stability_unchecked == "unstable" else stability_unchecked == "stable";
              message = ''
                vintagestory-nix: Calling `mkVintageStory` with `unstable` is deprecated.
                Version stability is now determined automatically from the version string.

                However, the value passed for `unstable` does not match the inferred value.

                Version: "${version}"
                Explicit stability: { stability = ${if unstable then "unstable" else "stable"}; }
                Inferred stability: { stability = "${stability_unchecked}"; }
              ''
              + (
                if stability_unchecked == "pre" then
                  ''

                    Note: prerelease versions were never supported via the `unstable` arg;
                    therefore, a prerelease will _always_ fail this assertion if `unstable`
                    is defined, regardless of value.
                  ''
                else
                  ""
              );
            }
          ]
          [
            ''
              vintagestory-nix: Calling `mkVintageStory` with `unstable` is deprecated.
              Version stability is now determined automatically from the version string.

              If you are seeing this warning, then it is safe to remove this argument,
              as the explicit value equals the inferred value.

              Version: "${version}"
              Explicit stability: { stability = ${if unstable then "unstable" else "stable"}; }
              Inferred stability: { stability = "${stability_unchecked}"; }
            ''
          ]
          stability_unchecked;
    in
    fetchzip {
      url = "https://cdn.vintagestory.at/gamefiles/${stability}/vs_client_linux-x64_${version}.tar.gz";
      ${
        if lib.hasSuffix "sha256-" hash
        then "hash"
        else "sha256"
      } =
        hash;
    };

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  runtimeLibs =
    [
      cairo
      libGLU
      libglvnd
      pipewire
      libpulseaudio
    ]
    ++ lib.optionals x11Support [
      xorg.libX11
      xorg.libXi
      xorg.libXcursor
    ]
    ++ lib.optionals waylandSupport [
      wayland
      libxkbcommon
    ];

  desktopItems = [
    (makeDesktopItem {
      name = "vintagestory";
      desktopName = "Vintage Story";
      exec = "vintagestory";
      icon = "vintagestory";
      comment = "Innovate and explore in a sandbox world";
      categories = ["Game"];
    })
    (makeDesktopItem {
      name = "vsmodinstall-handler";
      desktopName = "Vintage Story 1-click Mod Install Handler";
      comment = "Handler for vintagestorymodinstall:// URI scheme";
      exec = "vintagestory -i %u";
      mimeTypes = ["x-scheme-handler/vintagestorymodinstall"];
      noDisplay = true;
      terminal = false;
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/vintagestory $out/bin $out/share/pixmaps $out/share/fonts/truetype
    cp -r * $out/share/vintagestory
    cp $out/share/vintagestory/assets/gameicon.xpm $out/share/pixmaps/vintagestory.xpm
    cp $out/share/vintagestory/assets/game/fonts/*.ttf $out/share/fonts/truetype

    rm -rvf $out/share/vintagestory/{install,run,server}.sh

    runHook postInstall
  '';

  preFixup = let
    runtimeLibs' = lib.strings.makeLibraryPath finalAttrs.runtimeLibs;
    wrapperFlags = lib.trim ''
      --prefix LD_LIBRARY_PATH : "${runtimeLibs'}" \
      ${lib.strings.optionalString waylandSupport ''
        --set-default OPENTK_4_USE_WAYLAND 1 \
      ''} \
      --set-default mesa_glthread true
    '';
  in ''
    makeWrapper ${lib.meta.getExe dotnet-runtime_8} $out/bin/vintagestory \
      ${wrapperFlags} \
      --add-flags $out/share/vintagestory/Vintagestory.dll
    makeWrapper ${lib.meta.getExe dotnet-runtime_8} $out/bin/vintagestory-server \
      ${wrapperFlags} \
      --add-flags $out/share/vintagestory/VintagestoryServer.dll

    find "$out/share/vintagestory/assets/" -not -path "*/fonts/*" -regex ".*/.*[A-Z].*" | while read -r file; do
      local filename="$(basename -- "$file")"
      ln -sf "$filename" "''${file%/*}"/"''${filename,,}"
    done
  '';

  meta = {
    description = "In-development indie sandbox game about innovation and exploration";
    homepage = "https://www.vintagestory.at";
    license = lib.licenses.unfree;
    sourceProvenance = [lib.sourceTypes.binaryBytecode];
    platforms = ["x86_64-linux"];
    mainProgram = "vintagestory";
  };
})

vintagestory: {
  lib,
  dotnet-runtime_8,
}:
vintagestory.overrideAttrs {
  preFixup = let
    wrapperFlags = lib.trim ''
      --prefix LD_LIBRARY_PATH : "''${runtimeLibs[@]}" \
      --set-default mesa_glthread true \
      --set DOTNET_ROOT ${lib.getExe dotnet-runtime_8}/share/dotnet \
      --set DOTNET_ROLL_FORWARD Major
    '';
  in ''
    makeWrapper ${lib.getExe dotnet-runtime_8} $out/bin/vintagestory \
      ${wrapperFlags} \
      --add-flags $out/share/vintagestory/Vintagestory.dll

    makeWrapper ${lib.getExe dotnet-runtime_8} $out/bin/vintagestory-server \
      ${wrapperFlags} \
      --add-flags $out/share/vintagestory/VintagestoryServer.dll

    find "$out/share/vintagestory/assets/" -not -path "/fonts/" -regex "./.[A-Z]." | while read -r file; do
      local filename="$(basename -- "$file")"
      ln -sf "$filename" "''${file%/}"/"''${filename,,}"
    done
  '';
}

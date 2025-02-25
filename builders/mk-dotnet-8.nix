vintagestory: {dotnet-runtime_8}:
vintagestory.overrideAttrs (prevAttrs: {
  buildInputs = [ dotnet-runtime_8 ];
  preFixup = ''
    makeWrapper ${dotnet-runtime_8}/bin/dotnet $out/bin/vintagestory \
      --prefix LD_LIBRARY_PATH : "${prevAttrs.runtimeLibs}" \
      --set DOTNET_ROOT ${dotnet-runtime_8}/share/dotnet \
      --set DOTNET_ROLL_FORWARD Major \
      --add-flags $out/share/vintagestory/Vintagestory.dll

    makeWrapper ${dotnet-runtime_8}/bin/dotnet $out/bin/vintagestory-server \
      --prefix LD_LIBRARY_PATH : "${prevAttrs.runtimeLibs}" \
      --set DOTNET_ROOT ${dotnet-runtime_8}/share/dotnet \
      --set DOTNET_ROLL_FORWARD Major \
      --add-flags $out/share/vintagestory/VintagestoryServer.dll

    find "$out/share/vintagestory/assets/" -not -path "/fonts/" -regex "./.[A-Z]." | while read -r file; do
      local filename="$(basename -- "$file")"
      ln -sf "$filename" "''${file%/}"/"''${filename,,}"
    done
  '';
})

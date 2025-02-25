vintagestory: _:
vintagestory.overrideAttrs {
  fixupPhase = ''
    runHook preFixup

    mv $out/share/vintagestory/Vintagestory $out/share/vintagestory/Vintagestory-unwrapped
    cp $out/bin/vintagestory $out/share/vintagestory/Vintagestory

    runHook postFixup
  '';
}

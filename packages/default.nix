{
  builders,
  packages,
  lib,
}: let
  extraLibs = import ./lib.nix {inherit builders packages lib;};
  inherit
    (extraLibs)
    recursiveMergeAttrsList
    mkVSVersion
    mkMinorVersion
    mkLatest
    ;
in
  recursiveMergeAttrsList [
    (mkLatest "1.20") # Must be changed manually
    (mkMinorVersion (import ./1-20.nix mkVSVersion))
    (mkMinorVersion (import ./1-19.nix mkVSVersion))
    (mkMinorVersion (import ./1-18.nix mkVSVersion))
  ]

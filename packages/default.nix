{
  builders,
  packages,
  lib,
}: let
  extraLibs = import ./lib.nix {inherit builders packages lib;};
  inherit
    (extraLibs)
    mkVSVersion
    mkMinorVersion
    mkLatest
    ;
in
  mkLatest "1.20"
  // mkMinorVersion (import ./1-20.nix mkVSVersion)
  // mkMinorVersion (import ./1-19.nix mkVSVersion)
  // mkMinorVersion (import ./1-18.nix mkVSVersion)

{
  builders,
  packages,
  lib,
}: let
  # common libs
  clib = import ./libs {inherit packages lib;};
  v1 = import ./libs/v1.nix {inherit builders clib lib;};
  v2 = import ./libs/v2.nix {inherit builders clib lib;};

  inherit (clib) recursiveMergeAttrsList mkLatest;
in
  recursiveMergeAttrsList [
    (mkLatest "1.21") # WARN: Must be changed manually
    (v2.mkMinorVersion (import ./1-21.nix v2.mkVSVersion))
    (v1.mkMinorVersion (import ./1-20.nix v1.mkVSVersion))
    (v1.mkMinorVersion (import ./1-19.nix v1.mkVSVersion))
    (v1.mkMinorVersion (import ./1-18.nix v1.mkVSVersion))
  ]

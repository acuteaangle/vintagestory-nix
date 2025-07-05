{
  packages,
  lib,
}: let
  recursiveMergeAttrsList =
    builtins.foldl' (acc: attr: lib.attrsets.recursiveUpdate acc attr) {};

  # "1.20.4" => "1-20-4"
  normalizeVersion = builtins.replaceStrings ["."] ["-"];

  getVersion = set: (builtins.head (builtins.attrValues set)).version;
  highestVersion = versions:
    builtins.foldl' (
      maxSet: set: let
        maxSetVersion = getVersion maxSet;
        setVersion = getVersion set;
      in
        if builtins.compareVersions maxSetVersion setVersion == 1
        then maxSet // {version = maxSetVersion;}
        else set // {version = setVersion;}
    ) (builtins.head versions)
    versions;

  mkLatest = version: let
    v = normalizeVersion (lib.versions.majorMinor version);
  in rec {
    latest = packages."v${v}";
    # latest-net8 = warn ''
    #   'latest-net8' is deprecated, please use 'latest' instead.
    #   As of 1.21, Vintage Story is now built with .NET8.
    # '' latest;
    latest-net8 = packages."v${v}-net8";
  };
in {
  inherit
    recursiveMergeAttrsList
    normalizeVersion
    highestVersion
    mkLatest
    ;
}

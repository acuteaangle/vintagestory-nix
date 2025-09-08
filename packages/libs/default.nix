{
  packages,
  lib,
}: let
  recursiveMergeAttrsList =
    builtins.foldl' (acc: attr: lib.attrsets.recursiveUpdate acc attr) {};

  # "1.20.4" => "1-20-4"
  normalizeVersion = builtins.replaceStrings ["."] ["-"];

  getVersion = set: (builtins.head (builtins.attrValues set)).version;
  highestVersion = versions': let
    versions = builtins.filter (el: builtins.match ".*-rc\.[0-9]{1,2}" (getVersion el) == null) versions';
  in
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
    latest-net8 = builtins.warn ''
      'latest-net8' is deprecated, please use 'latest' instead. As of 1.21, Vintage Story officially uses dotnet8.
    '' latest;
  };
in {
  inherit
    recursiveMergeAttrsList
    normalizeVersion
    highestVersion
    mkLatest
    ;
}

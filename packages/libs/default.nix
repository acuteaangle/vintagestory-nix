{
  packages,
  lib,
}: let
  inherit
    (builtins)
    foldl'
    replaceStrings
    head
    attrValues
    filter
    match
    compareVersions
    warn
    ;
  inherit (lib.attrsets) recursiveUpdate;
  inherit (lib.versions) majorMinor;

  recursiveMergeAttrsList =
    foldl' (acc: attr: recursiveUpdate acc attr) {};

  # "1.20.4" => "1-20-4"
  normalizeVersion = replaceStrings ["."] ["-"];

  getVersion = set: (head (attrValues set)).version;
  highestVersion = versions': let
    versions = filter (el: match ".*-rc\.[0-9]{1,2}" (getVersion el) == null) versions';
  in
    foldl' (
      maxSet: set: let
        maxSetVersion = getVersion maxSet;
        setVersion = getVersion set;
      in
        if compareVersions maxSetVersion setVersion == 1
        then maxSet // {version = maxSetVersion;}
        else set // {version = setVersion;}
    ) (head versions)
    versions;

  mkLatest = version: let
    v = normalizeVersion (majorMinor version);
  in rec {
    latest = packages."v${v}";
    latest-net8 = warn ''
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

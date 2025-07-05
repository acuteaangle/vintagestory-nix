{
  builders,
  packages,
  lib,
}: let
  # "1.20.4" => "1-20-4"
  normalizeVersion = builtins.replaceStrings ["."] ["-"];

  recursiveMergeAttrsList = builtins.foldl' (acc: attr: lib.attrsets.recursiveUpdate acc attr) {};

  mkVSVersion = {
    version,
    hash,
  }: let
    v = normalizeVersion version;
    attrs = {
      "v${v}" = builders.mkVintageStory {inherit version hash;};
      "v${v}-net8" = builders.mkDotnet8 attrs."v${v}";
    };
  in
    attrs;

  mkMinorVersion = versions: let
    getVersion = set: (builtins.head (builtins.attrValues set)).version;

    highestVersionSet =
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

    # "1.20.4" => "1-20"
    majorMinor = normalizeVersion (lib.versions.majorMinor highestVersionSet.version);
    highestVersion = normalizeVersion highestVersionSet.version;

    latestVersion = {
      "v${majorMinor}" = highestVersionSet."v${highestVersion}";
      "v${majorMinor}-net8" = highestVersionSet."v${highestVersion}-net8";
    };
  in
    recursiveMergeAttrsList ([latestVersion] ++ versions);

  mkLatest = version: let
    v = normalizeVersion (lib.versions.majorMinor version);
  in {
    latest = packages."v${v}";
    latest-net8 = packages."v${v}-net8";
  };
in {
  inherit
    recursiveMergeAttrsList
    mkVSVersion
    mkMinorVersion
    mkLatest
    ;
}

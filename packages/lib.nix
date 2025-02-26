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
      net7."v${v}" = builders.mkVintageStory {inherit version hash;};
      net7."v${v}-m" = builders.mkMerged attrs.net7."v${v}";
      net8."v${v}" = builders.mkDotnet8 attrs.net7."v${v}";
      net8."v${v}-m" = builders.mkMerged attrs.net8."v${v}";
    };
  in
    attrs;


  mkMinorVersion = versions: let
    getVersion = set: (builtins.head (builtins.attrValues set.net7)).version;

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
      net7."v${majorMinor}" = highestVersionSet.net7."v${highestVersion}";
      net7."v${majorMinor}-m" = highestVersionSet.net7."v${highestVersion}-m";
      net8."v${majorMinor}" = highestVersionSet.net8."v${highestVersion}";
      net8."v${majorMinor}-m" = highestVersionSet.net8."v${highestVersion}-m";
    };
    merged = recursiveMergeAttrsList ([latestVersion] ++ versions);
  in
    merged;


  mkLatest = version: let
    v = normalizeVersion (lib.versions.majorMinor version);
  in {
    net7.latest = packages.net7."v${v}";
    net7.latest-m = packages.net7."v${v}-m";
    net8.latest = packages.net8."v${v}";
    net8.latest-m = packages.net8."v${v}-m";
  };
in {
  inherit
    recursiveMergeAttrsList
    mkVSVersion
    mkMinorVersion
    mkLatest
    ;
}

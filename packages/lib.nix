{
  builders,
  packages,
  lib,
}: let
  # "1.20.4" => "1-20-4"
  normalizeVersion = builtins.replaceStrings ["."] ["-"];


  mkVSVersion = {
    version,
    hash,
  }: let
    v = normalizeVersion version;
    attrs = {
      "v${v}" = builders.mkVintageStory {inherit version hash;};
      "v${v}-m" = builders.mkMerged attrs."v${v}";
      "v${v}-net8" = builders.mkDotnet8 attrs."v${v}";
      "v${v}-net8-m" = builders.mkMerged attrs."v${v}-net8";
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
      "v${majorMinor}-m" = highestVersionSet."v${highestVersion}-m";
      "v${majorMinor}-net8" = highestVersionSet."v${highestVersion}-net8";
      "v${majorMinor}-net8-m" = highestVersionSet."v${highestVersion}-net8-m";
    };
    merged = latestVersion // lib.mergeAttrsList versions;
  in
    merged;


  mkLatest = version: let
    v = normalizeVersion (lib.versions.majorMinor version);
  in {
    latest = packages."v${v}";
    latest-m = packages."v${v}-m";
    latest-net8 = packages."v${v}-net8";
    latest-net8-m = packages."v${v}-net8-m";
  };
in {inherit mkVSVersion mkMinorVersion mkLatest;}

pkgs: rec {
  # Wrapper function to easily package a new version of Vintage Story.
  #
  # mkVintageStory {version = "1.20.4"; hash = "sha256-Hgp2u/y2uPnJhAmPpwof76/woFGz4ISUXU+FIRMjMuQ=";}
  # => <Vintage Story derivation>
  mkVintageStory = pkgs.callPackage (import ./mk-vintage-story.nix);

  # Override a Vintage Story derivation to replace .NET 7 with .NET 8.
  #
  # mkDotnet8 pkgs.vintagestory
  # => <Vintage Story derivation that uses .NET 8>
  mkDotnet8 = vs: pkgs.callPackage (import ./mk-dotnet-8.nix vs) {};

  # Wrapper function to replace the game's default executable with the one wrapped by Nix,
  # such as `$out/share/vintagestory/Vintagestory` is the same as `$out/bin/vintagestory`.
  # The original `$out/share/vintagestory/Vintagestory` is renamed to `Vintagestory-unwrapped`.
  #
  # mkMerged pkgs.vintagestory
  # => <Vintage Story derivation >
  mkMerged = vs: pkgs.callPackage (import ./mk-merged.nix vs) {};

  # Wrapper function for the wrapper functions above
  mkVintageStoryNet8 = set: mkDotnet8 (mkVintageStory set);
}

```
█▀█ ▄▀█ ▄▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀
█▀▀ █▀█ ▀▄▄ █░█ █▀█ █▄█ ██▄ ▄█
```

---

This directory contains all the Vintage Story packages.

## .NET 7 is EOL, long live .NET 8
Currently, Vintage Story uses .NET 7, which has reached End-Of-Life.

This means that trying to install the game using Nix results in an
error because .NET 7 is marked as insecure.

This flake provides two namespaces for Vintage Story packages.
- <kbd>.net7</kbd> for "vanilla" packages, built the same way as in nixpkgs.
- <kbd>.net8</kbd> for packages patched to use .NET 8 instead.

## Usage
```Nix
{inputs, ...}: let
  # Access the set of package you want, either `net7` or `net8`
  VSPkgs = inputs.vintagestory-nix.packages.${system}.net8;
in [
  # Select a specific, fixed version
  VSPkgs.v1-20-4
  # Select a major version
  # Will get updated if a new patch of that version is released
  VSPkgs.v1-20
  # Select the latest released version
  VSPkgs.latest
]
```

## Special "merged" packages
Every package comes with a "merged" version, that has the following differences:

- `<vintagestory>/share/vintagestory/Vintagestory` is renamed `Vintagestory-unwrapped`.
- `<vintagestory>/bin/vintagestory` is copied to replace the previous executable.

This is usefull to some tools that needs to access the full game's directory and launch it through its executable.

Currently, only used for VS Launcher.

```Nix
{inputs, ...}: let
  VSPkgs = inputs.vintagestory-nix.packages.${system}.net8;
in [
  VSPkgs.v1-20-4-m
  VSPkgs.v1-20-m
  VSPkgs.latest-m
]
```

## Complete list of all packages
You can get a full list of all packages using `nix repl`'s autocompletion.

```sh
nix repl
:lf github:PierreBorine/vintagestory-nix
packages.x86_64-linux.net8.<TAB> # press tab
```

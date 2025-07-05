```
█▀█ ▄▀█ ▄▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀
█▀▀ █▀█ ▀▄▄ █░█ █▀█ █▄█ ██▄ ▄█
```

---

<p align="center">
This directory contains all the packaged Vintage Story versions.
<br><br><b>🧭 Navigation</b><br>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix"><b>🏠Home</b></a></kbd>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/tools"><b>🔧Tools</b></a></kbd>
</p>

## Usage
```nix
{inputs, ...}: let
  VSPkgs = inputs.vintagestory-nix.packages.x86_64-linux;
in [
  # Select a specific, fixed version.
  VSPkgs.v1-20-4

  # Select a minor version.
  # Will get updated if a new patch of that version is packaged.
  VSPkgs.v1-20

  # Select the latest packaged version.
  VSPkgs.latest

  # Select a .NET8 patched version
  VSPkgs.v1-19-7-net8
  VSPkgs.v1-20-net8
]
```

Get the full list using using the following command:
```sh
nix flake show github:PierreBorine/vintagestory-nix
```

### "`-net8`" packages
Because .NET 7 has reached End-Of-Life on the 14th of May 2024, it is marked as insecure on nixpkgs.

This means that trying to install the game throws an error if you didn't add `dotnet-runtime-7.0.20` to your `permittedInsecurePackages`.

This flake provides packages suffixed with `-net8` for versions up to 1.20.12 that subtitute .NET7 with .NET8.

I did not encounter issues in my playtime with these packages so I assume they are safe to use.

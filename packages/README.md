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
The recommended way is to use the overlay

```nix
# configuration.nix
{inputs, ...}: {
  nixpkgs = {
    overlays = [inputs.vintagestory-nix.overlays.default];
  };
}
```

You can then access all packages through the `vintagestoryPackages` namespace.
```nix
{pkgs, ...}:
with pkgs.vintagestoryPackages; [
  # Select a specific, fixed version.
  v1-20-4

  # Select a minor version.
  # Will get updated if a new patch of that version is packaged.
  v1-20

  # Select the latest packaged version.
  latest

  # Select a .NET8 patched version
  v1-19-7-net8
  v1-20-net8
]
```

##### Example
```nix
{pkgs, ...}: {
  home.packages = [pkgs.vintagestoryPackages.latest-net8];

  programs.vs-launcher = {
    enable = true;
    installedVersions = with pkgs.vintagestoryPackages; [
      v1-20-4-net8
    ];
  };
}
```

> [!TIP]
> Get the full list of packages using the following command:
> ```sh
> nix flake show github:PierreBorine/vintagestory-nix
> ```

## "`-net8`" packages
Because .NET 7 has reached End-Of-Life on the 14th of May 2024, it is marked as insecure on nixpkgs.

This means that trying to install the game throws an error if you didn't add `dotnet-runtime-7.0.20` to your `permittedInsecurePackages`.

This flake provides packages suffixed with `-net8` for versions up to 1.20.12 that subtitute .NET7 with .NET8.

I did not encounter issues in my playtime with these packages so I assume they are safe to use.

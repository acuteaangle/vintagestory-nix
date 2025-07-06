<p align="center">
█░█ ▀█▀ █▄░█ ▀█▀ ▄▀█ █▀▀ █▀▀ █▀ ▀█▀ █▀█ █▀█ ▀▄▀ ▄▄ █▄░█ ▀█▀ ▀▄▀<br>
▀▄▀ ▄█▄ █░▀█ ░█░ █▀█ █▄█ ██▄ ▄█ ░█░ █▄█ █▀▄ ░█░ ░░ █░▀█ ▄█▄ ▄▀▄
</p>

---

<p align="center">
A flake to help you on your <a href="https://www.vintagestory.at">Vintage Story</a> journey on NixOS.
<br><br><b>🧭 Navigation</b><br>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/packages"><b>📦Packages</b></a></kbd>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/tools"><b>🔧Tools</b></a></kbd>
</p>

## Features

#### 📦 Plenty of Vintage Story packages
Get the full list using using the following command:
```sh
nix flake show github:PierreBorine/vintagestory-nix
```

#### 🛡️ .NET 7 free packages

#### 🔧 Modding tools with Home Manager modules
- **VS Launcher** (unfree) - [github](https://github.com/XurxoMF/vs-launcher) - [moddb](https://mods.vintagestory.at/show/mod/16326)
- **Rustique** (MIT) - [github](https://github.com/Tekunogosu/Rustique) - [moddb](https://mods.vintagestory.at/rustique)
- More to come...

## Usage
Add this flake as an input to yours
```nix
# flake.nix
inputs = {
  vintagestory-nix = {
    url = "github:PierreBorine/vintagestory-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

Add the overlay
```nix
# configuration.nix
{inputs, ...}: {
  nixpkgs.overlays = [inputs.vintagestory-nix.overlays.default];
}
```

### Vintage Story packages
See the [relevant README](https://github.com/PierreBorine/vintagestory-nix/tree/master/packages) for more complete docs.
```nix
{pkgs, ...}: {
  home.packages = [
    pkgs.vintagestoryPackages.v1-20-12
    pkgs.vintagestoryPackages.v1-19
    pkgs.vintagestoryPackages.latest
  ];
}
```

### Modding Tools
See the [relevant README](https://github.com/PierreBorine/vintagestory-nix/tree/master/tools) for more complete docs.
```nix
{inputs, pkgs, ...}: {
  imports = [inputs.vintagestory-nix.homeManagerModules.default];

  home.packages = [
    pkgs.vintagestoryPackages.rustique
    pkgs.vintagestoryPackages.vs-launcher
  ];

  # or

  programs.vs-launcher = {
    enable = true;
    installedVersions = [
      pkgs.vintagestoryPackages.v1-19-4
    ];
  };
}
```

## Thanks
- to the [Vintage Story team](https://www.vintagestory.at/aboutus.html) for their incredible game
- to [XurxoMF](https://github.com/XurxoMF) for making VS Launcher
- to [Vixenin](https://github.com/NixOS/nixpkgs/issues/360384#issuecomment-2557412151) for the .NET8 trick
- to [dtomvan](https://github.com/dtomvan/vs2nix/blob/main/parts/programs/rustique.nix) for the rustique derivation

<p align="center">
█░█ ▀█▀ █▄░█ ▀█▀ ▄▀█ █▀▀ █▀▀ █▀ ▀█▀ █▀█ █▀█ ▀▄▀ ▄▄ █▄░█ ▀█▀ ▀▄▀<br>
▀▄▀ ▄█▄ █░▀█ ░█░ █▀█ █▄█ ██▄ ▄█ ░█░ █▄█ █▀▄ ░█░ ░░ █░▀█ ▄█▄ ▄▀▄
</p>

---

<p align="center">
A comprehensive (WIP) Nix flake to help you in your
<a href="https://www.vintagestory.at">Vintage Story</a> journey on NixOS.
<br><br><b>📚 Docs:</b><br>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/packages"><b>✨Packages</b></a></kbd>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/tools"><b>🔧Tools</b></a></kbd>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/packages"><b>🔨Builders</b></a></kbd>
</p>

> [!WARNING]
> **vintagestory-nix** is highly work-in-progress, things may not work but game packages
> should be moslty fine.

## Features

### ✨ Plenty of Vintage Story packages

### 🛡️ .NET 7 free packages

### 🔧 Modding tools with Home Manager modules
- VS Launcher: [github](https://github.com/XurxoMF/vs-launcher) - [moddb](https://mods.vintagestory.at/show/mod/16326) - Proprietary
- VS ModsUpdater: [github](https://github.com/Laerinok/VS_ModsUpdater) - [moddb](https://mods.vintagestory.at/show/mod/7341) - MIT


> [!WARNING]
> These tools are poorly packaged, and although they are usable, they may not work properly.<br>
> See [the docs](https://github.com/PierreBorine/vintagestory-nix/tree/master/tools) for more infos
> and known issues.

## Adding to the flake's inputs
```Nix
inputs = {
  vintagestory-nix = {
    url = "github:PierreBorine/vintagestory-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

## Thanks
- to [XurxoMF](https://github.com/XurxoMF) for making VS Launcher
- to [Laerinok](https://github.com/Laerinok) for making VS ModsUpdater

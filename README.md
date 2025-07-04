<p align="center">
█░█ ▀█▀ █▄░█ ▀█▀ ▄▀█ █▀▀ █▀▀ █▀ ▀█▀ █▀█ █▀█ ▀▄▀ ▄▄ █▄░█ ▀█▀ ▀▄▀<br>
▀▄▀ ▄█▄ █░▀█ ░█░ █▀█ █▄█ ██▄ ▄█ ░█░ █▄█ █▀▄ ░█░ ░░ █░▀█ ▄█▄ ▄▀▄
</p>

---

<p align="center">
A flake to help you on your
<a href="https://www.vintagestory.at">Vintage Story</a> journey on NixOS.
<br><br><b>📚 Docs:</b><br>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/packages"><b>✨Packages</b></a></kbd>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/tools"><b>🔧Tools</b></a></kbd>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/packages"><b>🔨Builders</b></a></kbd>
</p>

## Features

### ✨ Plenty of Vintage Story packages

### 🛡️ .NET 7 free packages

### 🔧 Modding tools with Home Manager modules
- VS Launcher: [github](https://github.com/XurxoMF/vs-launcher) - [moddb](https://mods.vintagestory.at/show/mod/16326) - Proprietary

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

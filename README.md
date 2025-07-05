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
- More to come...

## Usage
Add this flake as an input to yours
```nix
inputs = {
  vintagestory-nix = {
    url = "github:PierreBorine/vintagestory-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

### A new Vintage Story version is out and I want it now !
You can install pretty much any version with the `mkVintageStory` function.

Do note that this method may not work if the new version got substantial changes
to the point it requiers an updated derivation.
```nix
{inputs, ...}: {
  home.packages = [
    (inputs.vintagestory-nix.lib.mkVintageStory {
      version = "1.24.8";
      hash = "sha256-Hgp2u/y2uPnJhAmPpwof76/woFGz4ISUXU+FIRMjMuQ=";
    })
  ];
}
```

## Thanks
- the [Vintage Story team](https://www.vintagestory.at/aboutus.html) for their incredible game
- to [XurxoMF](https://github.com/XurxoMF) for making VS Launcher
- to [Vixenin](https://github.com/NixOS/nixpkgs/issues/360384#issuecomment-2557412151) for the .NET8 trick

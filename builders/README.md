```
▀█▀ █▀█ █▀█ █░░ █▀
░█░ █▄█ █▄█ █▄▄ ▄█
```

---

This directory contains builders to easiliy packages different versions of Vintage Story.

See [`default.nix`](https://github.com/PierreBorine/vintagestory-nix/blob/master/builders/default.nix) for documentation.

## Package a more recent version of Vintage Story

> [!NOTE]
> These builders most certainly won't work if you are trying to package a version
> older than `1.18.8`. As versions past this one are using .NET 4.

You can use the same builders used in this flake, to package versions that are not (yet?) included here.
```Nix
{inputs, ...}: let
  VSBuilers = inputs.vintagestory-nix.lib.builders;
in {
  home.packages = [
    (VSBuilers.mkVintageStory { # Make a .NET 7 version
      version = "1.24.8";
      hash = "sha256-Hgp2u/y2uPnJhAmPpwof76/woFGz4ISUXU+FIRMjMuQ=";
    })

    (VSBuilers.mkVintageStoryNet8 { # Make a .NET 8 version
      version = "1.24.8";
      hash = "sha256-Hgp2u/y2uPnJhAmPpwof76/woFGz4ISUXU+FIRMjMuQ=";
    })
  ];
}
```

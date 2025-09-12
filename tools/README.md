```
▀█▀ █▀█ █▀█ █░░ █▀
░█░ █▄█ █▄█ █▄▄ ▄█
```

---

<p align="center">
This directory contains packages and home-manager modules for some modding tools.
<br><br><b>🧭 Navigation</b><br>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix/tree/master/packages"><b>📦Packages</b></a></kbd>
<kbd><a href="https://github.com/PierreBorine/vintagestory-nix"><b>🏠Home</b></a></kbd>
</p>

## Packages
- `rustique`
- `vs-launcher`
- `vsmodelcreator`

## Home-Manager modules
- `all` (all modules)
- `default` (link to `all`)
- `vs-launcher`

## Rustique
[Rustique](https://github.com/Tekunogosu/Rustique) is a Rust command-line interface,
for managing and updating Vintage Story mods and their dependencies.

It works the same way as an Operating System package manager.

## VS Launcher
[VS Launcher](https://github.com/XurxoMF/vs-launcher) is an Electron-based game versions and mods manager.<br>
You can easily create isolated installations of Vintage Story to have different modpacks at different game versions.

Vintage Story versions installed inside the app won't start on NixOS, this is why a Home Manager module is provided.

#### Maximal example usage
> [!IMPORTANT]
> Game versions installed using `installedVersions` have to be manually registered inside VS Launcher.

```nix
# home.nix
{inputs, pkgs, ...}: {
  imports = [inputs.vintagestory-nix.homeModules.default];

  programs.vs-launcher = {
    enable = true; # Install VS Launcher
    package = pkgs.vintagestoryPackages.vs-launcher; # default
    # Change the directory, relative to $HOME,
    # in which to link installed versions
    gameVersionsDir = ".config/VSLGameVersions"; # default
    installedVersions = with pkgs.vintagestoryPackages; [
      # Current version I'm playing on with mods
      v1-20-4-net8

      # I have an active save with some friends
      # I don't want to mess with updating mods
      v1-19-8-net8
    ];
  };

  # Can still have a normal install
  home.packages = [pkgs.vintagestoryPackages.latest];
}
```

## VS Model Creator
[VS Model Creator](https://github.com/anegostudios/vsmodelcreator) is the official tool for creating and animating blocks, items and entities for Vintage Story.

[Here](https://wiki.vintagestory.at/Modding:VS_Model_Creator) is a link to the wiki with guides on how to use the software.

> [!NOTE]
> I haven't extensively tested this one but it worked well in my toying.
>
> Anyhow, if you find any packaging-related issue, do not hesitate reporting it.

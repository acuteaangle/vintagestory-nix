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
{inputs, ...}: let
  VSPkgs = inputs.vintagestory-nix.packages.x86_64-linux;
in {
  imports = [inputs.vintagestory-nix.homeManagerModules.default];

  programs.vs-launcher = {
    enable = true; # Install VS Launcher
    package = VSPkgs.vs-launcher; # default
    # Change the directory, relative to $HOME,
    # in which to link installed versions
    gameVersionsDir = ".config/VSLGameVersions"; # default
    installedVersions = with VSPkgs; [
      # Current version I'm playing on with mods
      v1-20-4-net8

      # I have an active save with some friends
      # I don't want to mess with updating mods
      v1-19-8-net8
    ];
  };

  # Can still have a normal install
  home.packages = [VSPkgs.latest];
}
```

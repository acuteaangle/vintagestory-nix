```
▀█▀ █▀█ █▀█ █░░ █▀
░█░ █▄█ █▄█ █▄▄ ▄█
```

---

This directory contains packages for some modding tools.

> [!WARNING]
> These tools are poorly packaged, although they are *usable*, they may not work properly.

## Packages
```Nix
{inputs, ...}: let
  VSTools = inputs.vintagestory-nix.packages.${system}.tools;
in [
  VSTools.vs-launcher
  VSTools.vs-mods-updater
]
```

## VS Launcher
VS Launcher (VSL) is an Electron-based proprietary game versions and mods manager.<br>
You can easily create isolated installations of Vintage Story to have different modpacks at different game versions.

Vintage Story versions installed through VSL won't start on NixOS, this is why a Home Manager module is provided.

#### Maximal example usage
```Nix
# home.nix
{inputs, ...}: let
  VSPkgs = inputs.vintagestory-nix.packages.${system}.net8;
in {
  programs.vs-launcher = {
    enable = true; # Install VS Launcher
    # Change the directory, relative to $HOME,
    # in which to link installed versions
    gameVersionsDir = ".config/VSLGameVersions"; # default
    # Derivations installed here have to use the "-m" suffix
    installedVersions = with VSPkgs; [
      # Current version I'm playing on with mods
      v1-20-4-m

      # I have an active save with some friends
      # I don't want to mess with updating mods
      v1-19-8-m
    ];
  };

  # Can still have a normal install
  home.packages = [VSPkgs.latest];
}
```

> [!IMPORTANT]
> Game versions installed using `installedVersions` have to be manually registered inside VSL.
> I do plan to make this automatic tho.

> [!TIP]
> Having multiple versions of the game obviously eats more space.<br>
> One way to reduce that usage is by only using "-m" packages.<br>
> `home.packages = [VSPkgs.latest-m];` because <kbd>v1-20-4</kbd> != <kbd>v1-20-4-m</kbd>.
> There shouldn't be any drawbacks.

> [!WARNING]
> Currently, launching VS Launcher with an application launcher (through the .desktop file)
> doesn't summon a window.
> The process is there, but no window will appear.
>
> Launching it from a terminal (`vs-launcher`) does work without issues but I need to investigate.

## VS ModsUpdater
VS ModsUpdater is in a state where it can't really be configured or used correctly on NixOS.

Executing it will result in a bunch of files being created in $PWD.

This is mainly here for testing purposes, you should ignore it.

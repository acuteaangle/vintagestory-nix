```
▀█▀ █▀█ █▀█ █░░ █▀
░█░ █▄█ █▄█ █▄▄ ▄█
```

---

This directory contains packages for some modding tools.

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
    installedVersions = with VSPkgs; [
      # Current version I'm playing on with mods
      v1-20-4

      # I have an active save with some friends
      # I don't want to mess with updating mods
      v1-19-8
    ];
  };

  # Can still have a normal install
  home.packages = [VSPkgs.latest];
}
```

> [!IMPORTANT]
> Game versions installed using `installedVersions` have to be manually registered inside VSL.
> I do plan to make this automatic tho.

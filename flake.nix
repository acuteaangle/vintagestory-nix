{
  description = "A flake to help you on your Vintage Story journey on NixOS";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    inherit (nixpkgs) lib;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "vintagestory"
            "vs-launcher"
            "rustory"
          ];
        permittedInsecurePackages = [
          "dotnet-runtime-7.0.20"
        ];
      };
    };
    packages = self.packages.${system};
  in {
    lib = {
      builders = import ./builders pkgs;
      inherit (self.lib.builders) mkVintageStory;
    };

    packages.${system} =
      {default = packages.latest;}
      // import ./tools pkgs
      // import ./packages {
        inherit (self.lib) builders;
        inherit packages lib;
      };

    overlays.default = final: prev: {
      vintagestoryPackages =
        {default = final.vintagestoryPackages.latest;}
        // import ./tools prev
        // import ./packages {
          packages = final.vintagestoryPackages;
          builders = import ./builders prev;
          inherit (prev) lib;
        };
    };

    homeModules = import ./tools/hm.nix {inherit packages;};

    homeManagerModules = let
      deprecateTo = builtins.warn "vintagestory-nix: `homeManagerModules` is deprecated, please use `homeModules` instead.";
    in {
      default = deprecateTo self.homeModules.vs-launcher;
      vs-launcher = deprecateTo self.homeModules.vs-launcher;
    };

    nixosModules.default = import ./module;
  };
}

{
  description = "WIP Nix flake to make your Vintage Story journey easier on NixOS";

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
          ];
        permittedInsecurePackages = [
          "dotnet-runtime-7.0.20"
        ];
      };
    };
    packages = self.packages.${system};
  in {
    lib.builders = import ./builders pkgs;

    packages.${system} =
      {default = packages.net7.latest;}
      // import ./tools pkgs
      // import ./packages {
        inherit (self.lib) builders;
        inherit packages lib;
      };

    homeManagerModules =
      {default = self.homeManagerModules.all;}
      // import ./tools/hm.nix {inherit packages;};

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          prefetch-npm-deps
          nix-prefetch
          nodejs
        ];
      };
  };
}

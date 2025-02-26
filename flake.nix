{
  description = "WIP Nix flake to make your Vintage Story journey easier on NixOS";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    packages = self.packages.${system};
  in {
    lib.builders = import ./builders pkgs;

    packages.${system} =
      {default = packages.net7.latest;}
      // import ./tools pkgs
      // import ./packages {
        inherit (self.lib) builders;
        inherit (nixpkgs) lib;
        inherit packages;
      };

    homeManagerModules =
      {default = self.homeManagerModules.all;}
      // import ./tools/hm.nix {inherit packages;};
  };
}

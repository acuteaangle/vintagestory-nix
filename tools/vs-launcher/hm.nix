vs-launcher: {
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption types;
  cfg = config.programs.vs-launcher;
in {
  options.programs.vs-launcher = {
    enable = mkEnableOption "VS Launcher";

    gameVersionsDir = mkOption {
      type = types.str;
      default = ".config/VSLGameVersions";
      description = "Path to the directory in which Vintage Story versions should be installed, relative to $HOME";
      example = ".config/VSLauncher/GameVersions";
    };

    installedVersions = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "List of Vintage Story packages to add to VS Launcher's GameVersions directory";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [vs-launcher];

    home.file = builtins.listToAttrs (builtins.map (
        vintagestory: {
          name = "${cfg.gameVersionsDir}/${vintagestory.version}";
          value.source = "${vintagestory}/share/vintagestory";
        }
      )
      cfg.installedVersions);
  };
}

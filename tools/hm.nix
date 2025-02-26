{packages}: rec {
  vs-launcher = import ./vs-launcher/hm.nix packages.tools.vs-launcher;
  # vs-mods-updater = import ./vs-mods-updater/hm.nix packages.tools.vs-mods-updater;

  all =
    vs-launcher
    # // vs-mods-updater
    ;
}

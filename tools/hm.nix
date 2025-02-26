{packages}: rec {
  vs-launcher = import ./vs-launcher/hm.nix packages.vs-launcher;
  # vs-mods-updater = import ./vs-mods-updater/hm.nix packages.vs-mods-updater;

  all =
    vs-launcher
    # // vs-mods-updater
    ;
}

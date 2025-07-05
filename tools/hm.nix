{packages}: rec {
  vs-launcher = import ./vs-launcher/hm.nix packages.vs-launcher;

  all =
    vs-launcher
    ;
}

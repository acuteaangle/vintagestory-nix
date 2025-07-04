{packages}: rec {
  vs-launcher = import ./vs-launcher/hm.nix packages.tools.vs-launcher;

  all =
    vs-launcher
    ;
}

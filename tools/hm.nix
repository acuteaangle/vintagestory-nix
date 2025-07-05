{packages}: rec {
  vs-launcher = import ./vs-launcher/hm.nix packages;

  all =
    vs-launcher
    ;
}

{packages}: rec {
  vs-launcher = import ./vs-launcher/hm.nix packages;

  default =
    vs-launcher;
}

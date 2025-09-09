{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "Rustique";
  version = "0.5.10";

  src = fetchFromGitHub {
    owner = "Tekunogosu";
    repo = "Rustique";
    rev = "v${version}";
    hash = "sha256-1hjhJD5kCaFtwDbOvuvRLNhN8OnmMh3rysj24+jmKCU=";
  };

  # tries to use clang and /usr/bin/mold, let's just not do that, and
  # use the GNU toolchain from stdenv
  postPatch = "rm -vf .cargo/config.toml";

  useFetchCargoVendor = true;
  cargoHash = "sha256-CMaQI3CkO3byXgzsRgdFzm3a3VW3AR8Z5FA2+zIUFmI=";

  # unstable rust feature path_add_extension
  env.RUSTC_BOOTSTRAP = 1;

  meta = {
    description = "The best Vintage Story mod manager you've never used";
    homepage = "https://github.com/Tekunogosu/Rustique";
    changelog = "https://github.com/Tekunogosu/Rustique/blob/${src.rev}/changelog.md";
    license = lib.licenses.mit;
    mainProgram = "Rustique";
  };
}

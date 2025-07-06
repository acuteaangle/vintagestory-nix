{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "Rustique";
  version = "0.5.9";

  src = fetchFromGitHub {
    owner = "Tekunogosu";
    repo = "Rustique";
    rev = "v${version}";
    hash = "sha256-tp0Gz7vSGmWq5pzHtnrGvj68BJHPmjqlqSBU73Nu9iM=";
  };

  # tries to use clang and /usr/bin/mold, let's just not do that, and
  # use the GNU toolchain from stdenv
  postPatch = "rm -vf .cargo/config.toml";

  useFetchCargoVendor = true;
  cargoHash = "sha256-dJSTxZefbzzTKOtOj9PQInqaVrhr5OKk3vvJeLMN8Bg=";

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

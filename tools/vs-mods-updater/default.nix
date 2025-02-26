{
  lib,
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "vs-mods-updater";
  version = "1.4.2";
  format = "other";

  src = fetchFromGitHub {
    owner = "Laerinok";
    repo = "VS_ModsUpdater";
    rev = "v${version}";
    hash = "sha256-RfXTPmEAgXvXNFFX+jfLU6G7vpyrWPJJ7yRU3EAtKkA=";
  };

  # Simply copy-pasted requirements.txt, but they don't
  # seems to be all necessary, leaving them just in case
  propagatedBuildInputs = with python3Packages; [
    # altgraph
    beautifulsoup4
    # certifi
    # charset-normalizer
    # colorama
    # defusedxml
    # fonttools
    fpdf2
    # idna
    # markdown-it-py
    # mdurl
    # packaging
    # pefile
    # pillow
    # pygments
    # pyinstaller
    # pyinstaller-hooks-contrib
    # pywinrm # pywin32-ctypes ?
    requests
    rich
    semver
    # soupsieve
    # tqdm
    # typing-extensions
    # urllib3
    wget
  ];

  installPhase = ''
    runHook preInstall

    # Only a partial fix, won't start otherwise
    sed -i 's/self.path_lang = Path("lang")/self.path_lang = Path(__file__).parent \/ "lang"/g' VS_ModsUpdater.py
    install -Dm755 VS_ModsUpdater.py $out/bin/${pname}
    cp -r lang $out/bin

    runHook postInstall
  '';

  meta = {
    description = "Easily update your favorite mods";
    homepage = "https://github.com/Laerinok/VS_ModsUpdater";
    changelog = "https://github.com/Laerinok/VS_ModsUpdater/blob/${src.rev}/changelog.txt";
    license = lib.licenses.mit;
    mainProgram = "vs-mods-updater";
    platforms = lib.platforms.all;
  };
}

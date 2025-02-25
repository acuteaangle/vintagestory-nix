mkVSVersion: [
  (mkVSVersion {
    version = "1.18.15";
    hash = "sha256-luZwRKVptSd69tCaf6Jv0YOfwOeDOcuY7VoL+21tTEo=";
  })
  (mkVSVersion {
    version = "1.18.14";
    hash = "sha256-PxSi+X16ARs4Ggw1jB9xBl2hk4vnlqVxnSv6VQ9jtFo=";
  })
  (mkVSVersion {
    version = "1.18.13";
    hash = "sha256-2+38tiwKC/OQaTW84+2/VF4+AxfZa5FulP+QAGcRj+I=";
  })
  (mkVSVersion {
    version = "1.18.12";
    hash = "sha256-akeW03+IdRvt3Fs3gF6TcYv9gD33DHPtpmiiMa0b92k=";
  })
  (mkVSVersion {
    version = "1.18.11";
    hash = "sha256-btP6ny36Q9ZfzOiAZu9pQpRkSUpWh7Qhh7cbJSMbf9o=";
  })
  (mkVSVersion {
    version = "1.18.10";
    hash = "sha256-xkpoVFZWlqhSSDn62MbhBYU6X+l5MmPxtrewg9xKuJc=";
  })
  (mkVSVersion {
    version = "1.18.9";
    hash = "sha256-Ul2+3Aasm3BZpbPS2aPrIUkO3Sky6gEfMHkxZYTewt4=";
  })
  (mkVSVersion {
    version = "1.18.8";
    hash = "sha256-q7MxmsWCGODOt/hCkCPz964m7az27SddIRBJ1vYg02k=";
  })
  # Versions past this used to have a different derivation in nixpkgs.
  # Hopefully, no one needs such old versions, I don't see why bother packaging them.
  # https://github.com/NixOS/nixpkgs/commit/a50269d1419600892dfe84c87b517748f938500b
]

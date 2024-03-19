{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "Tinymist";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "Myriad-Dreamin";
    repo = "tinymist";
    rev = "${version}";
    hash = "sha256-NZm7bOK00IKfH+Mof1/cNdyRW4nsESBYXGfXG1RzgLs=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "typst-0.11.0" = "sha256-UzZ0tbC6Dhn178GQDyLl70WTp3h5WdaBCsEKgLisZ2M=";
    };
  };

  meta = with lib; {
    description = "Tinymist [ˈtaɪni mɪst] is an integrated language service for Typst [taɪpst]. You can also call it '微霭' [wēi ǎi] in Chinese.";
    homepage = "https://github.com/Myriad-Dreamin/tinymist";
    mainProgram = "tinymist";
    # changelog = "https://github.com/Myriad-Dreamin/tinymist/releases/tag/${src.rev}";
    maintainers = with maintainers; [parsifa1];
  };
}

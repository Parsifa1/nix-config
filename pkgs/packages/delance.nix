{
  pkgs,
  lib,
  node2nix
}:
pkgs.stdenv.mkDerivation {
  pname = "delance";
  version = "2024.3.100";
  src = pkgs.fetchgit {
    url = "https://git.sr.ht/~self/delance-runtime";
    # rev = "commit或tag";
    sha256 = "sha256-o7n4OkxwGh6PG/1ETGAdaUV2pkOx75Mwzxds4cyXQlo=";
  };
  nativeBuildInputs = [pkgs.unzip pkgs.nodejs pkgs.curl];

  PUBLISHER = "ms-python";
  EXTENSION = "vscode-pylance";
  BASEURL = "https://marketplace.visualstudio.com";
  vsix = pkgs.vscode-marketplace.ms-python.vscode-pylance;
  installPhase = ''
    export DELANCE_VSIX="$out/share/vscode/extension"
    node $src/install.mjs
  '';
  meta = {
    description = "https://git.sr.ht/~self/delance-runtime";
    homepage = lib.urls.homepage "https://git.sr.ht/~self/delance-runtime";
    maintainers = with lib.maintainers; [parsifa1]; # 确保维护者名称正确
  };
}

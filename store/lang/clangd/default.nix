{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home.file = {
    ".clang-format".source = ./.clang-format;
    ".clangd" = lib.mkIf isDarwin {
      text = import ./clangd.nix { inherit pkgs; };
    };
    ".gnupg/gpg-agent.conf" = lib.mkIf isDarwin {
      text = ''pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac'';
    };
  };
}

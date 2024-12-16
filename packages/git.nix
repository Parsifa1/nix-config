{ pkgs, ... }:
let
  inherit (pkgs) stdenv;
in
{
  programs.git = {
    enable = true;
    userName = "Parsifa1";
    userEmail = "li.aldric@gmail.com";
    package = pkgs.gitFull;
    extraConfig = {
      user.signingkey = "99B21766F86301CA";
      credential.helper = if stdenv.isDarwin then "osxkeychain" else "store";
      core.editor = "nvim";
      credential.credentialStore = if stdenv.isDarwin then null else "cache";
      commit.gpgsign = true;
    };
  };
}

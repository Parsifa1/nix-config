{ config, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    settings = {
      user = {
        name = "Parsifa1";
        email = "li.aldric@gmail.com";
        signingkey = "99B21766F86301CA";
      };
      credential.helper =
        if isDarwin then "osxkeychain" else "store --file $HOME/.config/git/credentials";
      core.editor = "nvim";
      credential.credentialStore = "cache";
      commit.gpgsign = !config.server;
    };
    ignores = [ ".DS_Store" ];
  };
}

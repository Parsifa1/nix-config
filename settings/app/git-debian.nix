{ pkgs, ... }:
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
      };
      credential.helper = if isDarwin then "osxkeychain" else "store";
      core.editor = "nvim";
      credential.credentialStore = "cache";
      commit.gpgsign = false;
    };
  };
}

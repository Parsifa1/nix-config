{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.git = {
    enable = true;
    userName = "Parsifa1";
    userEmail = "li.aldric@gmail.com";
    package = pkgs.gitFull;
    extraConfig = {
      credential.helper = if isDarwin then "osxkeychain" else "store";
      core.editor = "nvim";
      credential.credentialStore = "cache";
      commit.gpgsign = false;
    };
  };
}

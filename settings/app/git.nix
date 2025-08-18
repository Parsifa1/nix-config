{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.git = {
    enable = true;
    userName = "Parsifa1";
    userEmail = "li.aldric@gmail.com";
    package = pkgs.git;
    extraConfig = {
      user.signingkey = "99B21766F86301CA";
      credential.helper =
        if isDarwin then "osxkeychain" else "store --file $HOME/.config/git/credentials";
      core.editor = "nvim";
      credential.credentialStore = "cache";
      commit.gpgsign = true;
    };
    ignores = [ ".DS_Store" ];
  };
}

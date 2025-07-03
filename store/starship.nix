{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  inherit (lib) mkIf;
in
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      hostname.disabled = true;
      username.disabled = true;
      custom.fhs = mkIf isDarwin {
        command = "echo 🐧";
        when = ''
          test -n "$FHS"
        '';
      };
    };
  };
}

{
  lib,
  pkgs,
  config,
  ...
}:
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
      directory.read_only = mkIf (!config.server) "";
      username.disabled = true;
      custom.fhs = mkIf (!isDarwin) {
        command = "echo 🐧";
        when = "test -n \"$FHS\"";
      };
    };
  };
}

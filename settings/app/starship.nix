{
  cfg,
  pkgs,
  ...
}:
let
  inherit (pkgs.lib) mkIf;
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      username.disabled = true;
      hostname.detect_env_vars = [ "!WEZTERM_REMOTE_PANE" ];
      directory.read_only = mkIf (cfg.hideReadOnly or true) "";
      custom.fhs = mkIf (!isDarwin) {
        command = "echo 🐧";
        when = "test -n \"$FHS\"";
      };
    };
  };
}

{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    nix-direnv.enable = true;
    config = {
      warn_timeout = 0;
      hide_env_diff = true;
    };
  };
}

{ pkgs, ... }:
{
  programs.atuin = {
    package = pkgs.atuin;
    enable = true;
    settings = {
      style = "compact";
      logs = {
        dir = "~/.local/state/atuin/logs";
      };
    };
  };
}

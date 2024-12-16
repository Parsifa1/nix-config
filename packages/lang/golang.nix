{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gopls
  ];
  home.sessionVariables = {
    GOPATH = "/home/${config.home.username}/.local/share/go";
  };
}

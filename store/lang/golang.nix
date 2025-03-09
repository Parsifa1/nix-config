{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gopls
  ];
  home.sessionVariables = {
    GOPATH = "/home/${config.username}/.local/share/go";
  };
}

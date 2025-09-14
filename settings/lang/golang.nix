{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    gopls
  ];
  home.sessionVariables = {
    GOPATH = "$HOME/.local/share/go";
  };
}

{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: [
      pkgs.noto-fonts-color-emoji
      epkgs.melpaPackages.rime
    ];
  };
  home.packages = with pkgs; [
    rime-data
    pkg-config
  ];
  home.sessionVariables = {
    TD_PATH = pkgs.tdlib;
  };
}

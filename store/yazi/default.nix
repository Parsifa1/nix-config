{ lib, pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "63f9650";
    hash = "sha256-ZCLJ6BjMAj64/zM606qxnmzl2la4dvO/F5QFicBEYfU=";
  };
  starship = pkgs.fetchFromGitHub {
    owner = "Rolv-Apneseth";
    repo = "starship.yazi";
    rev = "6a0f3f7";
    sha256 = "sha256-q1G0Y4JAuAv8+zckImzbRvozVn489qiYVGFQbdCxC98=";
  };
  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "7ff7141";
    sha256 = "sha256-qRUAKlrYWV0qzI3SAQUYhnL3QR+0yiRc+0XbN/MyufI=";
  };
in
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableFishIntegration = true;
    initLua = ./init.lua;
    settings = lib.importTOML ./yazi.toml;
    theme = lib.importTOML ./theme.toml;
    keymap = lib.importTOML ./keymap.toml;
    plugins = {
      inherit starship exifaudio;
      git = "${yazi-plugins}/git.yazi";
      max-preview = "${yazi-plugins}/max-preview.yazi";
      smart-enter = "${yazi-plugins}/smart-enter.yazi";
    };
  };
}

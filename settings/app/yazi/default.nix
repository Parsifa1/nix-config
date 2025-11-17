{ lib, pkgs, ... }:
let
  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "4506f9d";
    sha256 = "sha256-RWCqWBpbmU3sh/A+LBJPXL/AY292blKb/zZXGvIA5/o=";
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
      inherit exifaudio;
      git = pkgs.yaziPlugins.git;
      starship = pkgs.yaziPlugins.starship;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
    };
  };
}

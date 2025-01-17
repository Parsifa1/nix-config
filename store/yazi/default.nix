{ lib, pkgs, ... }:
let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "7afba3a";
    hash = "sha256-w9dSXW0NpgMOTnBlL/tzlNSCyRpZNT4XIcWZW5NlIUQ=";
  };
  starship = pkgs.fetchFromGitHub {
    owner = "Rolv-Apneseth";
    repo = "starship.yazi";
    rev = "247f49d";
    sha256 = "sha256-0J6hxcdDX9b63adVlNVWysRR5htwAtP5WhIJ2AK2+Gs=";
  };
  exifaudio = pkgs.fetchFromGitHub {
    owner = "Sonico98";
    repo = "exifaudio.yazi";
    rev = "d794614";
    sha256 = "sha256-nXBxPG6PVi5vstvVMn8dtnelfCa329CTIOCdXruOxT4=";
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

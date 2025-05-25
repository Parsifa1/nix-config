{ lib, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.fastfetch = {
    enable = true;
    settings =
      let
        logo = pkgs.fetchurl {
          url = "https://github.com/sn0wm1x.png";
          hash = "sha256-7gAf++UN5o7+aP8jLno46zaEtni7vwNBrxD1pDkcA3A=";
        };
      in
      {
        logo = {
          type = if isDarwin then "kitty-direct" else "kitty";
          source = "${logo}";
          width = lib.mkIf (!isDarwin) 25;
          padding = {
            top = 1;
          };
        };
        modules = [
          "title"
          "os"
          "kernel"
          "uptime"
          {
            "type" = "packages";
            "format" = "{all}";
          }
          "shell"
          {
            "type" = "display";
            "key" = "Resolution";
            "compactType" = "original";
          }
          "de"
          "wm"
          "wmtheme"
          {
            "type" = "terminalfont";
            "key" = "font";
          }
          {
            "type" = "disk";
            "folders" = "/";
            "key" = "Disk";
          }
          "cpu"
          "gpu"
          {
            "type" = "memory";
            "key" = "RAM";
          }
        ];
      };
  };
}

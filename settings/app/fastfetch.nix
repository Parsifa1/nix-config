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
          "shell"
          {
            "type" = "display";
            "key" = "Resolution";
            "compactType" = "original";
          }
          "wm"
          "wmtheme"
          {
            "type" = "terminalfont";
            "key" = "font";
          }
          "cpu"
          "gpu"
          {
            "type" = "memory";
            "key" = "RAM";
            "percent" = {
              "type" = 3;
            };
          }
          {
            "type" = "disk";
            "folders" = "/";
            "key" = "Disk";
            "percent" = {
              "type" = 3;
            };
          }
        ];
      };
  };
}

{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  special =
    if isDarwin then
      {
        font-size = 18.5;
        window-height = 38;
        window-width = 154;
        window-padding-y = "1,1";
        macos-option-as-alt = true;
        macos-titlebar-style = "tabs";
        macos-icon = "custom-style";
        macos-icon-ghost-color = "mistyrose";
        macos-titlebar-proxy-icon = "visible";
        macos-icon-screen-color = "blue";
        keybind = [
          "super+enter=unbind"
          "option+left=unbind"
          "option+right=unbind"
          "ctrl+v=paste_from_clipboard"
          "command+q=text:\\x1b[113;3u" # send Alt + q with escape sequence
          "ctrl+shift+apostrophe=new_split:right"
          "ctrl+shift+semicolon=new_split:down"
        ];
        theme = "dark:Everforest,light:GruvboxLightHard";
      }
    else
      {
        font-size = 17.5;
        theme = "Everforest";
        command = "ssh parsifa1@127.0.0.1 -p 11451";
        window-height = 42;
        window-width = 170;
        keybind = [
          "ctrl+enter=unbind"
          "ctrl+v=paste_from_clipboard"
          "ctrl+shift+apostrophe=new_split:right"
          "ctrl+shift+semicolon=new_split:down"
        ];
      };
  settings = special // {
    font-family = [
      "IosevkaCloudtide Nerd Font"
      "LXGW WenKai"
    ];
    cursor-style = "block";
    confirm-close-surface = false;
    shell-integration-features = "no-cursor";
    window-title-font-family = "Iosevka Cloudtide";
  };
in
{
  programs.ghostty = {
    enable = true;
    package = if isDarwin then null else pkgs.ghostty;
    themes.Everforest = {
      background = "#272E33";
      foreground = "#d3c6aa";
      cursor-color = "#e69875";
      cursor-text = "#4c3743";
      palette = [
        "0=#7a8478"
        "1=#e67e80"
        "2=#a7c080"
        "3=#dbbc7f"
        "4=#7fbbb3"
        "5=#d699b6"
        "6=#83c092"
        "7=#f2efdf"
        "8=#a6b0a0"
        "9=#f85552"
        "10=#8da101"
        "11=#dfa000"
        "12=#3a94c5"
        "13=#df69ba"
        "14=#35a77c"
        "15=#fffbef"
      ];
      selection-background = "#4c3743";
      selection-foreground = "#d3c6aa";
    };
    enableFishIntegration = true;
    inherit settings;
  };
}

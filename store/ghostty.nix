{ pkgs, ... }:
let
  stdenv = pkgs.stdenv;
  special =
    if stdenv.isDarwin then
      {
        font-size = 18.5;
        window-height = 45;
        window-width = 170;
        window-padding-y = "1,1";
        macos-option-as-alt = true;
        macos-titlebar-style = "tabs";
        macos-icon = "custom-style";
        macos-icon-ghost-color = "mistyrose";
        macos-titlebar-proxy-icon = "visible";
        macos-icon-screen-color = "blue";
        keybind = [
          "ctrl+v=paste_from_clipboard"
          "ctrl+shift+apostrophe=new_split:right"
          "ctrl+shift+semicolon=new_split:down"
        ];
      }
    else
      {
        font-size = 17.5;
        theme = "Everforest Dark - Hard";
        command = "ssh parsifa1@127.0.0.1 -p 11451";
        window-height = 42;
        window-width = 170;
        keybind = [
          "ctrl+v=paste_from_clipboard"
          "ctrl+shift+apostrophe=new_split:right"
          "ctrl+shift+semicolon=new_split:down"
          "ctrl+enter=unbind"
        ];
      };
  settings = special // {
    font-family = [
      "IosevkaCloudtide Nerd Font"
      "LXGW WenKai"
    ];
    window-title-font-family = "Iosevka Cloudtide";
    theme = "Everforest Dark - Hard";
    background = "#272E33";
    cursor-style = "block";
    shell-integration-features = "no-cursor";
    confirm-close-surface = false;
  };
in
{
  programs.ghostty = {
    enable = true;
    package = if stdenv.isDarwin then null else pkgs.ghostty;
    enableFishIntegration = true;
    inherit settings;
  };
}

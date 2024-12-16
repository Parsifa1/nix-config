{ pkgs, ... }:
{
  home.packages = with pkgs; [
    texliveMedium
  ];
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      render-loading = true;
      adjust-open = "width";
      font = "monospace normal 15";
      window-title-basename = "true";
      selection-clipboard = "clipboard";
      notification-error-bg = "rgba(255,85,85,1)";
      notification-error-fg = "rgba(248,248,242,1)";
      notification-warning-bg = "rgba(255,184,108,1)";
      notification-warning-fg = "rgba(68,71,90,1)";
      notification-bg = "rgba(40,42,54,1)";
      notification-fg = "rgba(248,248,242,1)";
      completion-bg = "rgba(40,42,54,1)";
      completion-fg = "rgba(98,114,164,1)";
      completion-group-bg = "rgba(40,42,54,1)";
      completion-group-fg = "rgba(98,114,164,1)";
      completion-highlight-bg = "rgba(68,71,90,1)";
      completion-highlight-fg = "rgba(248,248,242,1)";
      index-bg = "rgba(40,42,54,1)";
      index-fg = "rgba(248,248,242,1)";
      index-active-bg = "rgba(68,71,90,1)";
      index-active-fg = "rgba(248,248,242,1)";
      inputbar-bg = "rgba(40,42,54,1)";
      inputbar-fg = "rgba(248,248,242,1)";
      statusbar-bg = "rgba(40,42,54,1)";
      statusbar-fg = "rgba(248,248,242,1)";
      highlight-color = "rgba(255,184,108,0.5)";
      highlight-active-color = "rgba(255,121,198,0.5)";
      default-bg = "rgba(40,42,54,1)";
      default-fg = "rgba(248,248,242,1)";
      render-loading-fg = "rgba(40,42,54,1)";
      render-loading-bg = "rgba(248,248,242,1)";
      recolor-lightcolor = "rgba(40,42,54,1)";
      recolor-darkcolor = "rgba(248,248,242,1)";
    };
  };
}

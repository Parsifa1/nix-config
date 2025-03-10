{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    ibm-plex
    noto-fonts
    lxgw-wenkai
    cloudtide.fonts
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    source-han-serif
  ];

}

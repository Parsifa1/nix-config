{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = with pkgs; [ imagemagick ];
    package = pkgs.neovim;
  };
  home.packages = with pkgs; [
    fnlfmt
    lua51Packages.lua
    luajitPackages.luarocks
    cloudtide.tree-sitter
  ];
}

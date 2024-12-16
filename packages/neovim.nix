{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    package = pkgs.neovim;
  };
  home.packages = with pkgs; [
    imagemagick
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
  ];
}

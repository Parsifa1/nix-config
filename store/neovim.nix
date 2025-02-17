{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];
    package = pkgs.neovim;
  };
  home.packages = with pkgs; [
    fnlfmt
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
  ];
}

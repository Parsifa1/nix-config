{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];
    # package = pkgs.neovim;
  };
  home.packages = with pkgs; [
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
  ];
}

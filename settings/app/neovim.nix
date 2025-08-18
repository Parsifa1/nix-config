{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = with pkgs; [ imagemagick ];
  };
  home.packages = with pkgs; [
    nixd
    tree-sitter
    lua51Packages.lua
    luajitPackages.luarocks
    (pkgs.writeShellScriptBin "v" "exec -a $0 ${pkgs.neovim}/bin/nvim $@")
  ];
}

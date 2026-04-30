{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = true;
    sideloadInitLua = true;
    extraPackages = with pkgs; [ imagemagick ];
  };
  home.packages = with pkgs; [
    nixd
    ast-grep
    tree-sitter
    lua51Packages.lua
    luajitPackages.luarocks
    (pkgs.writeShellScriptBin "v" "exec -a $0 ${pkgs.neovim}/bin/nvim $@")
  ];
}

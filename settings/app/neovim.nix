{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withRuby = true;
    withPython3 = true;
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

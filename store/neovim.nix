{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = with pkgs; [ imagemagick ];
  };
  home.packages = with pkgs; [
    fnlfmt
    lua51Packages.lua
    luajitPackages.luarocks
    cloudtide.tree-sitter
    (pkgs.writeShellScriptBin "v" "exec -a $0 ${pkgs.neovim}/bin/nvim $@")
  ];
}

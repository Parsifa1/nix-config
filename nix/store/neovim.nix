{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
  };
  home.packages = with pkgs; [
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
  ];
}

{
  # inputs,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    # package = inputs.neovim-nightly.packages.${pkgs.system}.default;
  };
  home.packages = with pkgs; [
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
  ];
}

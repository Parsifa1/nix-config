{
  # inputs,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    # package = inputs.neovim-nightly.packages.${pkgs.system}.default;
  };
  home.packages = with pkgs; [
    imagemagick
    lua51Packages.lua
    luajitPackages.luarocks
    tree-sitter
  ];
}

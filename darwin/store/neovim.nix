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
  home.sessionVariables = {
    # for blink.cmp lib
    LIBRARY_PATH = "$LIBRARY_PATH:${pkgs.libiconv.out}/lib";
  };
}

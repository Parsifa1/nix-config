{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
  };
  home = {
    packages = with pkgs; [lua51Packages.lua luajitPackages.luarocks sqlite.out tree-sitter];
    # sessionVariables = {LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so";};
  };
}

{pkgs, ...}: {
  /* lsp-packages = with pkgs; [
    # language servers
    lua-language-server
    marksman #markdown
    yaml-language-server
    tinymist
    nodePackages.vscode-langservers-extracted #html, json
    nodePackages.typescript-language-server
    vue-language-server
    nodePackages."@astrojs/language-server"
    taplo #toml
    ruff-lsp #python
    tailwindcss-language-server
    gopls
    nil

    # formatter
    alejandra
    typstyle
    ruff
    stylua
    nodePackages.prettier
  ];  */
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
  };
  home = {
    packages = with pkgs; [lua51Packages.lua luajitPackages.luarocks sqlite.out tree-sitter];
    sessionVariables = { LIBSQLITE = "${pkgs.sqlite.out}/lib/libsqlite3.so"; };
  };
}

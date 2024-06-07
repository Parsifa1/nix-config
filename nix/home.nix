{pkgs, ...}: let
  packages = with pkgs; [
    fastfetch
    ripgrep
    eza
    bat
    yarn
    nh
    helix
    delta
    fzf
    fd
    which
    tree
    btop
    dust
    duf
    typst
    pandoc
    git-credential-manager
    nix-output-monitor
    nerd-font-patcher
  ];

  neovim-packages = with pkgs; [
    tree-sitter
    # language servers
    lua-language-server
    clang-tools_18 #cpp
    # rust-analyzer
    marksman #markdown
    yaml-language-server
    tinymist
    nodePackages.vscode-langservers-extracted #html, json
    nodePackages.typescript-language-server
    nodePackages."@astrojs/language-server"
    taplo #toml
    ruff-lsp #python
    tailwindcss-language-server
    nil

    # formatter
    alejandra
    typstyle
    ruff
    stylua
    nodePackages.prettier

    # others
    typst-preview
  ];
in {
  home = {
    username = "parsifa1";
    homeDirectory = "/home/parsifa1";
    packages = neovim-packages ++ packages;
  };

  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Dark";
      package = pkgs.whitesur-gtk-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  imports = map (d: ./store + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./store)));

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}

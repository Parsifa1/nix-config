{pkgs, ...}: let
  unstable-packages = with pkgs.unstable; [
    fastfetch
    hyfetch
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
    unzip
    dust
    duf
    typst
    git-credential-manager
    nix-output-monitor
  ];

  neovim-packages = with pkgs; [
    tree-sitter
    # language servers
    lua-language-server
    clang-tools #cpp
    rust-analyzer
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
    python311Packages.autopep8
    alejandra
    cloudtide.typstyle
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
    packages = neovim-packages ++ unstable-packages;
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

  imports = map (d: ./programs + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./programs)));
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}

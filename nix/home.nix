{
  lib,
  pkgs,
  ...
}: let
  unstable-packages = with pkgs.unstable; [
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
    rustup
    pandoc
    git-credential-manager
    nix-output-monitor
    nerd-font-patcher
  ];

  neovim-packages = with pkgs; [
    tree-sitter
    # language servers
    lua-language-server
    clang-tools #cpp
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
    sessionVariables = {
      # for nvidia-smi
      NIX_LD_LIBRARY_PATH = lib.mkDefault (lib.makeLibraryPath [pkgs.stdenv.cc.cc]);
      NIX_LD = lib.mkDefault "${pkgs.glibc}/lib/ld-linux-x86-64.so.2";
    };
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

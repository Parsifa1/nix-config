{pkgs, ...}: let
  unstable-packages = with pkgs.unstable; [
    fastfetch
    hyfetch
    ripgrep
    eza
    bat
    fzf
    fd
    which
    tree
    nix-output-monitor
    btop
    unzip
    lazygit
    dust
    duf
    typst
    git-credential-manager
    nh
  ];

  mason-packages = with pkgs; [
    tree-sitter
    # language servers
    nodePackages."@astrojs/language-server"
    python311Packages.autopep8
    clang-tools
    pkgs.nodePackages.vscode-langservers-extracted
    lua-language-server
    marksman
    nil
    nodePackages.prettier
    vscode-extensions.ms-pyright.pyright
    ruff
    ruff-lsp
    rust-analyzer
    stylua
    tailwindcss-language-server
    taplo
    nodePackages.typescript-language-server
    yaml-language-server
    pkgs.cloudtide.tinymist
    pkgs.cloudtide.typstyle
    # cloudtide.delance
    pkgs.alejandra
  ];
in {
  home = {
    username = "parsifa1";
    homeDirectory = "/home/parsifa1";
    packages = mason-packages ++ unstable-packages;
  };

  imports = map (d: ./programs + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./programs))) ++ [./config.nix];
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}

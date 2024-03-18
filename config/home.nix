{
  pkgs,
  alejandra,
  system,
  ...
}: let
  unstable-packages = with pkgs.unstable; [
    fastfetch
    ripgrep
    eza
    bat
    fzf
    fd
    which
    tree
    nix-output-monitor
    btop
    starship
    yazi
    unzip
    zoxide
    lazygit
    dust
    duf
    direnv
    atuin
    typst
    git-credential-manager
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
    alejandra.defaultPackage.${system}
  ];
in {
  home = {
    username = "parsifa1";
    homeDirectory = "/home/parsifa1";
    packages = mason-packages ++ unstable-packages;
  };
  imports = map (d: ./programs + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./programs)));
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}

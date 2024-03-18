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
    git-credential-manager
  ];

  mason-packages = with pkgs; [
    # language servers
    nodePackages.typescript-language-server
    yaml-language-server
    lua-language-server
    clang-tools
    nil
    ruff
    ruff-lsp
    marksman
    nodePackages.prettier
    rust-analyzer
    nodePackages."@astrojs/language-server"
    python311Packages.autopep8
    pkgs.nodePackages.vscode-langservers-extracted
    vscode-extensions.ms-pyright.pyright
    tailwindcss-language-server
    alejandra.defaultPackage.${system}
    taplo
    # language formmater
    nixfmt
    stylua
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

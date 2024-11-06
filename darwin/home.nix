{ pkgs, ... }:
let
  packages = with pkgs; [
    nixfmt-rfc-style
    fastfetch
    onefetch
    tokei
    ripgrep
    eza
    bat
    yarn
    nh
    delta
    fzf
    fd
    which
    tree
    btop
    dust
    duf
    git-credential-manager
    neovim
    tree-sitter
  ];

  gcc = pkgs.gcc14.cc;
in
{
  home = {
    username = "parsifa1";
    homeDirectory = "/Users/parsifa1";
    packages = packages;
    file = {
      ".clangd".text = ''
        CompileFlags:
          Add:
            - -I${gcc}/include
            - -I${gcc}/include/c++/14.2.0/
            - -I${gcc}/include/c++/14.2.0//backward
            - -I${gcc}/include/c++/14.2.0//aarch64-apple-darwin
            - -I${gcc}lib/gcc/aarch64-apple-darwin/14.2.0/include
            - -I${gcc}/lib/gcc/aarch64-apple-darwin/14.2.0/include-fixed
            - -I${pkgs.apple-sdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
            - -I${pkgs.apple-sdk}/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks
      '';
      ".clang-format".source = ../dotfile/.clang-format;
      ".wakatime.cfg".source = ../dotfile/.wakatime.cfg;
    };
  };

  imports = map (d: ./store + d) (map (n: "/" + n) (with builtins; attrNames (readDir ./store)));

  programs.home-manager.enable = true;
  home.stateVersion = "24.05"; # Please read the comment before changing.
}

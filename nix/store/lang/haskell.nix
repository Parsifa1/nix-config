{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ghc
    haskellPackages.haskell-language-server
  ];
}

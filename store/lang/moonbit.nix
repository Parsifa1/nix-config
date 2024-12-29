{ pkgs, ... }:
{
  home.packages = with pkgs; [
    moonbit-bin.moonbit.latest
    moonbit-bin.lsp.latest
  ];
}

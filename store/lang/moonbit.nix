{ pkgs, ... }:
{
  home.packages = with pkgs; [
    moonbit-bin.moonbit.latest
    moonbit-bin.lsp.v0_1_20250310-a7a1e9804
  ];
}

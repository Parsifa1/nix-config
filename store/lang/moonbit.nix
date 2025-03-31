{ pkgs, ... }:
{
  home.packages = with pkgs; [
    moonbit-bin.moonbit.latest
    moonbit-bin.lsp."0_1_202503100"
  ];
}

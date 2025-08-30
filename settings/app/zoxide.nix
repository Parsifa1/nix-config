{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableFishIntegration = true;
  };
}

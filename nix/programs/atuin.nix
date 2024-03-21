{pkgs, ...}: {
  programs.atuin = {
    package = pkgs.atuin;
    enable = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
    };
  };
}

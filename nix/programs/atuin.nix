{...}: {
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
    };
  };
}

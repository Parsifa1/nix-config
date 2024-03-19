{lib, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = lib.importTOML ./yazi.toml;
    theme = lib.importTOML ./theme.toml;
    keymap = lib.importTOML ./keymap.toml;
  };
}

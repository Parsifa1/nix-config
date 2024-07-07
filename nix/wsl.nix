{pkgs, ...}: {
  wsl = {
    enable = true;
    defaultUser = "parsifa1";
    startMenuLaunchers = true;
    nativeSystemd = true;
  };
  environment.systemPackages = with pkgs; [cloudtide.win32yank wslu];

  networking.hostName = "nixos";
  system.stateVersion = "23.11";
}

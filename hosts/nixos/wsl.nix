{ pkgs, ... }:
{
  wsl = {
    enable = true;
    defaultUser = "parsifa1";
    startMenuLaunchers = true;
    useWindowsDriver = true;
  };
  environment.systemPackages = with pkgs; [
    cloudtide.win32yank
    wslu
  ];

  networking.hostName = "nixos";
}

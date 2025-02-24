{ pkgs, ... }:
{
  wsl = {
    enable = true;
    defaultUser = "parsifa1";
    startMenuLaunchers = true;
    useWindowsDriver = true;
    wslConf.interop.appendWindowsPath = false;
  };
  environment.systemPackages = with pkgs; [
    cloudtide.win32yank
    wslu
  ];

  networking.hostName = "nixos";
}

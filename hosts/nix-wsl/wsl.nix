{ config, pkgs, ... }:
let
  pwsh = "exec -a $0 /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe $@";
in
{
  wsl = {
    enable = true;
    defaultUser = config.username;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    wslConf.interop.appendWindowsPath = false;
  };
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "powershell.exe" pwsh)
    (pkgs.writeShellScriptBin "nvidia-smi" "/run/opengl-driver/lib/nvidia-smi")
    cloudtide.win32yank
    wslu
  ];

  networking.hostName = "nixos";
}

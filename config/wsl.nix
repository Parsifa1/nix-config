{ pkgs, ... }:
{
  # 主要区别就是这个 wsl 模块
  wsl = {
    enable = true;
    defaultUser = "parsifa1";
    # 创建软件的桌面快捷方式
    startMenuLaunchers = true;
  };

  environment.systemPackages = [ (import ./win32yank.nix { inherit pkgs; }) ];

  networking.hostName = "nixos";
  system.stateVersion = "23.11";
}

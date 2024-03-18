{pkgs, ...}: {
  wsl = {
    enable = true;
    defaultUser = "parsifa1";
    # 创建软件的桌面快捷方式
    startMenuLaunchers = true;
    nativeSystemd = true;
  };

  environment.systemPackages = [(import ./pkgs/win32yank.nix {inherit pkgs;})];

  networking.hostName = "nixos";
  system.stateVersion = "23.11";
}

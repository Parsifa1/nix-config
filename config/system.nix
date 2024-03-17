{ pkgs, pkg-neovim, ... }:
{
  programs.fish.enable = true;
  users.users.parsifa1 = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [ pkg-neovim.neovim-nightly ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoYJIrhUQGPbm2xzV9Rd6H6vfGeGC2Okr4yHdIxyLJgZTvbY6F9/HUKuIOo/EpZkNs+YXrxw6WVbMFMRhdgYLHbaWxlWmd5VqA+2msLw/Xj1KtObCJp3bwYqvIv6O6tzCc7KuQf+kY3MZLKCxMRV6Mv6AzdeD4rsc78V9XKN4VOT+meHXGfP8/Di42FRNratyQQKiKZh+Pcz8wW+kYq4n+8PkYLkIzpboAfvp2Kmbv8ElkspCKEpmlIXsDX+3Ara3zsY+5j7rfuh0U2c+/g9m33EwhtQ6YTGB6UDjQRoa4bu/e3V6LJb77QuSZK4E6oGAiTgASP12Ns5oQkTTtwF36JYOrAYpGoiCsoAo1zDPHS1gDIJVq+AoUZ2WF1qW0s/rGOMEw3EoBvz5UQ1LmqaJ3uo4lnEkGyVYpeu4aMizDtL1DvRMJNhgyB2v37OoNiiva3sxCINBAlc0n4CebFUvYWd5xhS6EHfcKbQ/wL9udUKTMuZoR3DBIm5depm3F+ks= parsifal@LAPTOP-ALDRIC"
    ];
  };

  environment.systemPackages = with pkgs; [
    fish
    git
    vim
    wget
    curl
    gcc
    gnumake
    cargo
    nodejs
    openssh
    rocmPackages.llvm.clang
    python3
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.variables.EDITOR = "nvim";

  networking.proxy = {
    allProxy = "http://127.0.0.1:7891";
    httpProxy = "http://127.0.0.1:7891";
    httpsProxy = "http://127.0.0.1:7891";
    ftpProxy = "http://127.0.0.1:7891";
    noProxy = "localhost,127.0.0.1";
  };

  services.openssh = {
    enable = true;
    ports = [ 14514 ];
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
  };
}
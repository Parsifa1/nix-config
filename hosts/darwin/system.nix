# darwin.nix
{ inputs, pkgs, ... }:
{
  #临时使用软件包
  environment.systemPackages = with pkgs; [
    zig
    nixd
    gcc14
    gnupg
    rustup
    agenix
  ];

  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  programs.gnupg.agent.enable = true;

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    settings = {
      trusted-users = [ "parsifa1" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 1w";
    };
  };

  users.users.parsifa1 = {
    name = "parsifa1";
    home = "/Users/parsifa1";
    uid = 501;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpOQirGxMfUl3F8KQxjzDZg0POSIpeNk5ayZQvugQOm li.aldric@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoYJIrhUQGPbm2xzV9Rd6H6vfGeGC2Okr4yHdIxyLJgZTvbY6F9/HUKuIOo/EpZkNs+YXrxw6WVbMFMRhdgYLHbaWxlWmd5VqA+2msLw/Xj1KtObCJp3bwYqvIv6O6tzCc7KuQf+kY3MZLKCxMRV6Mv6AzdeD4rsc78V9XKN4VOT+meHXGfP8/Di42FRNratyQQKiKZh+Pcz8wW+kYq4n+8PkYLkIzpboAfvp2Kmbv8ElkspCKEpmlIXsDX+3Ara3zsY+5j7rfuh0U2c+/g9m33EwhtQ6YTGB6UDjQRoa4bu/e3V6LJb77QuSZK4E6oGAiTgASP12Ns5oQkTTtwF36JYOrAYpGoiCsoAo1zDPHS1gDIJVq+AoUZ2WF1qW0s/rGOMEw3EoBvz5UQ1LmqaJ3uo4lnEkGyVYpeu4aMizDtL1DvRMJNhgyB2v37OoNiiva3sxCINBAlc0n4CebFUvYWd5xhS6EHfcKbQ/wL9udUKTMuZoR3DBIm5depm3F+ks= parsifal@LAPTOP-ALDRIC"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgb0NbVy2X/Hbn0/MOJ49TJwwJ1DJp4Y+itBEOJvKgHzKLZyoOC5MhdLgy+6sIeaNXEjVcRTAhvKWJISVGEhx6LjuLDEhLpn+7KwZOa//iqoE4WImw8xfbqZDWvGgc+ZOM7r0JpjzXSa23SKdhHD/iZYS6YW7EeOLEbcDSxeKCIdzEff7m/7khUp34Cuw6IOV7lNmHTO+oyyr26M/CtXNuDX4kTygL3D7y5xje/AFzTXD5lwWIEIQi0lKwFPao9XSnK05Qlaj3mg2pg/qlscRoxmZ3nIJtIrQKgIn+l/QLJyh3kwZmI+PWzN+aNmqnwGh6nJxLuGhlue2dCAZx1tkvGmfnZIZNV2bqn5fKhQO8zqAHDziYzCWYN9pk3G9tXSXGBbNiEKTQ1IWFAlayuCf3JLNhwwwE+rww41CxplasQ9pho/atrKaCWHxka+SDdg94SaMEPaA9U3e9CqO6G8gRHNFTnhowNZ3CQteG4BsU7UD0RCRASDBeF1SHECx+oEU= li.aldric@gmail.com"
    ];
  };
  users.knownUsers = [ "parsiafa1" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.parsifa1 = import ./home.nix;
    extraSpecialArgs = { inherit inputs pkgs; };
  };

  fonts.packages = with pkgs; [
    ibm-plex
    noto-fonts
    lxgw-wenkai
    cloudtide.fonts
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
    source-han-serif
  ];
  environment.variables.FONTCONFIG_FILE = "${pkgs.makeFontsConf {
    fontDirectories = [ "/Library/Fonts" ];
  }}";

  age.identityPaths = [ "/Users/parsifa1/.ssh/id_ed25519" ];
  programs.fish.enable = true;

  system.stateVersion = 5;
}

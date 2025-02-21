{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  programs.fish.enable = true;
  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;

  users.users.parsifa1 = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$fdy82j7goIaaecK3SEUKE0$JqPx5WkZ0OMRbXVB/d2dQIA/c7dSV3BXUAV7vlBcVOA";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpOQirGxMfUl3F8KQxjzDZg0POSIpeNk5ayZQvugQOm li.aldric@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoYJIrhUQGPbm2xzV9Rd6H6vfGeGC2Okr4yHdIxyLJgZTvbY6F9/HUKuIOo/EpZkNs+YXrxw6WVbMFMRhdgYLHbaWxlWmd5VqA+2msLw/Xj1KtObCJp3bwYqvIv6O6tzCc7KuQf+kY3MZLKCxMRV6Mv6AzdeD4rsc78V9XKN4VOT+meHXGfP8/Di42FRNratyQQKiKZh+Pcz8wW+kYq4n+8PkYLkIzpboAfvp2Kmbv8ElkspCKEpmlIXsDX+3Ara3zsY+5j7rfuh0U2c+/g9m33EwhtQ6YTGB6UDjQRoa4bu/e3V6LJb77QuSZK4E6oGAiTgASP12Ns5oQkTTtwF36JYOrAYpGoiCsoAo1zDPHS1gDIJVq+AoUZ2WF1qW0s/rGOMEw3EoBvz5UQ1LmqaJ3uo4lnEkGyVYpeu4aMizDtL1DvRMJNhgyB2v37OoNiiva3sxCINBAlc0n4CebFUvYWd5xhS6EHfcKbQ/wL9udUKTMuZoR3DBIm5depm3F+ks= parsifal@LAPTOP-ALDRIC"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgb0NbVy2X/Hbn0/MOJ49TJwwJ1DJp4Y+itBEOJvKgHzKLZyoOC5MhdLgy+6sIeaNXEjVcRTAhvKWJISVGEhx6LjuLDEhLpn+7KwZOa//iqoE4WImw8xfbqZDWvGgc+ZOM7r0JpjzXSa23SKdhHD/iZYS6YW7EeOLEbcDSxeKCIdzEff7m/7khUp34Cuw6IOV7lNmHTO+oyyr26M/CtXNuDX4kTygL3D7y5xje/AFzTXD5lwWIEIQi0lKwFPao9XSnK05Qlaj3mg2pg/qlscRoxmZ3nIJtIrQKgIn+l/QLJyh3kwZmI+PWzN+aNmqnwGh6nJxLuGhlue2dCAZx1tkvGmfnZIZNV2bqn5fKhQO8zqAHDziYzCWYN9pk3G9tXSXGBbNiEKTQ1IWFAlayuCf3JLNhwwwE+rww41CxplasQ9pho/atrKaCWHxka+SDdg94SaMEPaA9U3e9CqO6G8gRHNFTnhowNZ3CQteG4BsU7UD0RCRASDBeF1SHECx+oEU= li.aldric@gmail.com"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.parsifa1 = import ./home.nix;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      icu
      gmp
      glibc
      openssl
      stdenv.cc.cc
    ];
  };

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      trusted-users = [ "parsifa1" ];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cloudtide.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cloudtide.cachix.org-1:9NZ1Mah2+u8cd/CmVffFV23z5uFNpZSrhfgTt5fuN/4="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  environment.systemPackages = with pkgs; [
    delta
    wget
    curl
    gnupg
    pinentry-gnome3
    gcc14
    zig
    clang-tools_18
    cmake
    gnumake
    openssh
    websocat
    unzip
    rustup
    nixd
    nix-init
    nix-output-monitor
    devenv
    dconf
    agenix
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ibm-plex
      noto-fonts
      lxgw-wenkai
      cloudtide.fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      source-han-serif
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Sans" ];
        sansSerif = [ "Noto Serif" ];
        monospace = [ "Iosevka Cloudtide" ];
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
    settings = {
      max-cache-ttl = 604800000;
      default-cache-ttl = 604800000;
      allow-preset-passphrase = "";
      no-allow-external-cache = "";
    };
  };

  age.identityPaths = [ "/home/parsifa1/.ssh/id_rsa" ];
  virtualisation.docker.enable = true;
  system.stateVersion = "23.11";
}

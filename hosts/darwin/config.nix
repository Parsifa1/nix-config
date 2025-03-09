{
  pkgs,
  config,
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
in
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.username}.imports = [ inputs.self.homeModules.darwin ];
  };

  users = {
    knownUsers = [ config.username ];
    users.${config.username} = {
      uid = 501;
      name = config.username;
      home = "/Users/${config.username}";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIpOQirGxMfUl3F8KQxjzDZg0POSIpeNk5ayZQvugQOm li.aldric@gmail.com"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoYJIrhUQGPbm2xzV9Rd6H6vfGeGC2Okr4yHdIxyLJgZTvbY6F9/HUKuIOo/EpZkNs+YXrxw6WVbMFMRhdgYLHbaWxlWmd5VqA+2msLw/Xj1KtObCJp3bwYqvIv6O6tzCc7KuQf+kY3MZLKCxMRV6Mv6AzdeD4rsc78V9XKN4VOT+meHXGfP8/Di42FRNratyQQKiKZh+Pcz8wW+kYq4n+8PkYLkIzpboAfvp2Kmbv8ElkspCKEpmlIXsDX+3Ara3zsY+5j7rfuh0U2c+/g9m33EwhtQ6YTGB6UDjQRoa4bu/e3V6LJb77QuSZK4E6oGAiTgASP12Ns5oQkTTtwF36JYOrAYpGoiCsoAo1zDPHS1gDIJVq+AoUZ2WF1qW0s/rGOMEw3EoBvz5UQ1LmqaJ3uo4lnEkGyVYpeu4aMizDtL1DvRMJNhgyB2v37OoNiiva3sxCINBAlc0n4CebFUvYWd5xhS6EHfcKbQ/wL9udUKTMuZoR3DBIm5depm3F+ks= parsifal@LAPTOP-ALDRIC"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgb0NbVy2X/Hbn0/MOJ49TJwwJ1DJp4Y+itBEOJvKgHzKLZyoOC5MhdLgy+6sIeaNXEjVcRTAhvKWJISVGEhx6LjuLDEhLpn+7KwZOa//iqoE4WImw8xfbqZDWvGgc+ZOM7r0JpjzXSa23SKdhHD/iZYS6YW7EeOLEbcDSxeKCIdzEff7m/7khUp34Cuw6IOV7lNmHTO+oyyr26M/CtXNuDX4kTygL3D7y5xje/AFzTXD5lwWIEIQi0lKwFPao9XSnK05Qlaj3mg2pg/qlscRoxmZ3nIJtIrQKgIn+l/QLJyh3kwZmI+PWzN+aNmqnwGh6nJxLuGhlue2dCAZx1tkvGmfnZIZNV2bqn5fKhQO8zqAHDziYzCWYN9pk3G9tXSXGBbNiEKTQ1IWFAlayuCf3JLNhwwwE+rww41CxplasQ9pho/atrKaCWHxka+SDdg94SaMEPaA9U3e9CqO6G8gRHNFTnhowNZ3CQteG4BsU7UD0RCRASDBeF1SHECx+oEU= li.aldric@gmail.com"
      ];
    };
  };

  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    optimise.automatic = true;
    settings = {
      trusted-users = [ config.username ];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      substituters = [
        "https://cache.nixos.org"
        "https://cloudtide.cachix.org"
        "https://nix-community.cachix.org"
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cloudtide.cachix.org-1:9NZ1Mah2+u8cd/CmVffFV23z5uFNpZSrhfgTt5fuN/4="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 1w";
    };
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

  environment = {
    variables.FONTCONFIG_FILE = "${pkgs.makeFontsConf {
      fontDirectories = [ "/Library/Fonts" ];
    }}";
    etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  programs = {
    gnupg.agent.enable = true;
    fish.enable = true;
  };

  system = {
    startup.chime = false;
    defaults.dock.autohide = true;
    stateVersion = 5;
  };

  imports = [ ./service.nix ];
}

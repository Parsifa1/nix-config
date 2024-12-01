# darwin.nix
{ pkgs, ... }:
{
  #临时使用软件包
  environment.systemPackages = with pkgs; [
    nixd
    gcc14
    zig
    gnupg
    rustup
    agenix
  ];

  services.nix-daemon.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  # enable logs for debugging
  launchd.daemons."activate-agenix".serviceConfig = {
    StandardErrorPath = "/Library/Logs/org.nixos.activate-agenix.stderr.log";
    StandardOutPath = "/Library/Logs/org.nixos.activate-agenix.stdout.log";
  };
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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoYJIrhUQGPbm2xzV9Rd6H6vfGeGC2Okr4yHdIxyLJgZTvbY6F9/HUKuIOo/EpZkNs+YXrxw6WVbMFMRhdgYLHbaWxlWmd5VqA+2msLw/Xj1KtObCJp3bwYqvIv6O6tzCc7KuQf+kY3MZLKCxMRV6Mv6AzdeD4rsc78V9XKN4VOT+meHXGfP8/Di42FRNratyQQKiKZh+Pcz8wW+kYq4n+8PkYLkIzpboAfvp2Kmbv8ElkspCKEpmlIXsDX+3Ara3zsY+5j7rfuh0U2c+/g9m33EwhtQ6YTGB6UDjQRoa4bu/e3V6LJb77QuSZK4E6oGAiTgASP12Ns5oQkTTtwF36JYOrAYpGoiCsoAo1zDPHS1gDIJVq+AoUZ2WF1qW0s/rGOMEw3EoBvz5UQ1LmqaJ3uo4lnEkGyVYpeu4aMizDtL1DvRMJNhgyB2v37OoNiiva3sxCINBAlc0n4CebFUvYWd5xhS6EHfcKbQ/wL9udUKTMuZoR3DBIm5depm3F+ks= parsifal@LAPTOP-ALDRIC"
    ];
  };
  users.knownUsers = [ "parsiafa1" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.parsifa1 = import ./home.nix;
  };

  # programs.zsh.enable = true;
  age.identityPaths = [ "/Users/parsifa1/.ssh/id_ed25519" ];
  programs.fish.enable = true;

  system.stateVersion = 5;
}

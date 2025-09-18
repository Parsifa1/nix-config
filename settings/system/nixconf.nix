{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  nix = {
    package = pkgs.nixVersions.latest;
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      trusted-users = [
        config.username
        "@admin"
        "root"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      substituters = [
        "https://cache.nixos.org"
        "https://cache.garnix.io"
        "https://cloudtide.cachix.org"
        "https://nix-community.cachix.org"
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "cloudtide.cachix.org-1:9NZ1Mah2+u8cd/CmVffFV23z5uFNpZSrhfgTt5fuN/4="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
    extraOptions = "!include ${config.sops.templates.nixconf-gh.path}";
    gc = {
      automatic = true;
    };
  };
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
}

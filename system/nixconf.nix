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
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
}

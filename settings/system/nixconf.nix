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
    settings = inputs.self.modules.nixCommon // {
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      trusted-users = [ config.username ];
    };
    extraOptions = "!include ${config.sops.templates.nixconf-gh.path}";
    gc = {
      automatic = true;
    };
  };
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
}

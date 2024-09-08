{
  inputs,
  lib,
  nixpkgs-master,
  pkgs,
  system,
  ...
}:
let
  pkgs-master = import nixpkgs-master {
    inherit system;
    config.allowUnfree = true;
  };
  overlays = with inputs; [
    # fix fastfetch
    (final: prev: {
      fastfetch = prev.fastfetch.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.directx-headers ];
        cmakeFlags = oldAttrs.cmakeFlags ++ [ (lib.cmakeBool "ENABLE_DIRECTX_HEADERS" true) ];
      });
    })

    #fix delta
    # (final: prev: {
    #   delta = pkgs-master.delta;
    #   nix-init = pkgs-master.nix-init;
    #   wezterm = pkgs-master.wezterm;
    # })

    # my nur overlays
    cloudtide.overlay

    #rust toolchain
    fenix.overlays.default
  ];
in
{
  nixpkgs = {
    overlays = overlays;
    config.allowUnfree = true;
  };
}

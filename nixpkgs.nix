{
  inputs,
  lib,
  nixpkgs-master,
  pkgs,
  system,
  ...
}: let
  pkgs-master = import nixpkgs-master {
    inherit system;
    config.allowUnfree = true;
  };
in {
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = with inputs; [
    # fix fastfetch
    (final: prev: {
      fastfetch = prev.fastfetch.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [pkgs.directx-headers];
        cmakeFlags = oldAttrs.cmakeFlags ++ [(lib.cmakeBool "ENABLE_DIRECTX_HEADERS" true)];
      });
    })
    # use master branch
    (final: prev: {
      ollama = pkgs-master.ollama;
    })

    # my nur overlays
    cloudtide.overlay

    #rust toolchain
    fenix.overlays.default
  ];
}

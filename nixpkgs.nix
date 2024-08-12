{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = with inputs; [
    # fix fastfetch
    (final: prev: {
      fastfetch = prev.fastfetch.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [pkgs.directx-headers];
        cmakeFlags = oldAttrs.cmakeFlags ++ [(lib.cmakeBool "ENABLE_DIRECTX_HEADERS" true)];
      });
    })

    # my nur overlays
    cloudtide.overlay

    #rust toolchain
    fenix.overlays.default
  ];
}

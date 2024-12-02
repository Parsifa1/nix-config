{
  pkgs,
  inputs,
  system,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  overlays = with inputs; [
    # fix fastfetch
    (final: prev: {
      fastfetch = prev.fastfetch.overrideAttrs (oldAttrs: {
        buildInputs =
          if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then
            oldAttrs.buildInputs ++ [ pkgs.directx-headers ]
          else
            oldAttrs.buildInputs;

        cmakeFlags =
          if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then
            oldAttrs.cmakeFlags ++ [ (lib.cmakeBool "ENABLE_DIRECTX_HEADERS" true) ]
          else
            oldAttrs.cmakeFlags;
      });
    })

    #bind agenix nh
    (final: prev: {
      agenix = inputs.agenix.packages.${system}.default;
      nh = inputs.nh.packages.${system}.default;
      # neovim = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    })

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
    hostPlatform = system;
  };
}

{
  inputs,
  inputs',
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
          if system == "x86_64-linux" then
            oldAttrs.buildInputs ++ [ prev.directx-headers ]
          else
            oldAttrs.buildInputs;

        cmakeFlags =
          if system == "x86_64-linux" then
            oldAttrs.cmakeFlags ++ [ (lib.cmakeBool "ENABLE_DIRECTX_HEADERS" true) ]
          else
            oldAttrs.cmakeFlags;
      });
    })

    #bind agenix nh
    (final: prev: {
      agenix = inputs'.agenix.packages.default;
      nh = inputs'.nh.packages.default;
      neovim = inputs'.neovim-nightly-overlay.packages.default;
      wezterm = inputs'.wezterm.packages.default;
    })

    # my nur overlays
    cloudtide.overlay

    #rust toolchain
    fenix.overlays.default
  ];
in

import inputs.nixpkgs {
  inherit system overlays;
  config.allowUnfree = true;

}

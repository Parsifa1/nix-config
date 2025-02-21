{
  inputs,
  inputs',
  system,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  # nixpkgs overlays
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
    #bind packages need overlay
    (final: prev: {
      agenix = inputs'.agenix.packages.default;
      nh = inputs'.nh.packages.default;
      wezterm = inputs'.wezterm.packages.default;
      # ghostty = inputs'.ghostty.packages.default;
      nvim = prev.neovim;
    })
    # my nur overlays
    cloudtide.overlay
    #rust toolchain
    fenix.overlays.default
    #neovim-nightly
    neovim-nightly-overlay.overlays.default
    #mbt toolchain
    moonbit-overlay.overlays.default
  ];
in
{
  nixpkgs = {
    inherit overlays;
    hostPlatform = system;
    config.allowUnfree = true;
  };
}

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
      nvim = prev.neovim;
      nh = inputs'.nh.packages.default;
      agenix = inputs'.agenix.packages.default;
      # fish4.0b
      fish = inputs'.nixpkgs-fish.legacyPackages.fish;
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

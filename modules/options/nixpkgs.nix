{ inputs, system, ... }:
let
  # nixpkgs overlays
  overlays = with inputs; [
    (final: prev: {
      nvim = prev.neovim;
      # agenix = inputs.agenix.packages.${system}.default;
      dtnix = inputs.detnix.packages."${system}".default;
    })
    # my nur overlays
    cloudtide.overlay
    # rust toolchain
    fenix.overlays.default
    # neovim-nightly
    neovim-nightly-overlay.overlays.default
    # mbt toolchain
    # moonbit-overlay.overlays.default
  ];
in
{
  nixpkgs = {
    inherit overlays system;
    config.allowUnfree = true;
  };
}

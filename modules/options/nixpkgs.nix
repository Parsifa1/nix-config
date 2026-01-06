{ inputs, system, ... }:
let
  # nixpkgs overlays
  overlays = with inputs; [
    (final: prev: {
      nvim = prev.neovim;
      clang-tools = inputs.clangd.legacyPackages.${system}.clang-tools;
      # agenix = inputs.agenix.packages.${system}.default;
    })
    # my nur overlays
    cloudtide.overlay
    #nh nightly
    nh.overlays.default
    # rust toolchain
    fenix.overlays.default
    # neovim-nightly
    # neovim-nightly-overlay.overlays.default
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

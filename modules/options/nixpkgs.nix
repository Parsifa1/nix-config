{ inputs, system, ... }:
let
  # nixpkgs overlays
  overlays = with inputs; [
    (final: prev: {
      nixfmt-rs = nixfmt-rs.packages.${system}.default;
    })
    # my nur overlays
    cloudtide.overlay
    # rust toolchain
    fenix.overlays.default
  ];
in
{
  nixpkgs = {
    inherit overlays system;
    config.allowUnfree = true;
  };
}

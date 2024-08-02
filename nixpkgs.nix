{inputs, ...}: {
  nixpkgs.config = {allowUnfree = true;};

  nixpkgs.overlays = with inputs; [
    # my nur overlays
    cloudtide.overlay

    #rust
    fenix.overlays.default
  ];
}

{inputs, ...}: {
  nixpkgs.overlays = with inputs; [
    #unstable overlays
    (self: super: {
      nixpkgs.config.allowUnfree = true;
    })

    # my nur overlays
    cloudtide.overlay

    #rust
    fenix.overlays.default
  ];
}

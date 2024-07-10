{inputs, ...}: {
  nixpkgs.overlays = with inputs; [
    #unstable overlays
    (self: super: {
      nixpkgs.config.allowUnfree = true;
    })

    # my nur overlays
    cloudtide.overlay

    #nur overlay
    nur.overlay

    # neovim
    neovim-nightly.overlays.default

    #rust
    fenix.overlays.default

    #yazi
    # yazi.overlays.default
  ];
}

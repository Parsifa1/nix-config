{inputs, ...}: {
  overlays = with inputs; [
    # my nur overlays
    cloudtide.overlay

    #nur overlay
    nur.overlay

    # neovim
    # neovim-nightly.overlays.default

    #unstable overlays
    (_final: prev: {
      unstable = import nixpkgs {
        inherit (prev) system;
        config = {allowUnfree = true;};
      };
    })
  ];
}

{inputs, ...}: {
  overlays = with inputs; [
    #nur overlay
    nur.overlay
    # my nur overlays
    cloudtide.overlay
    # nix formatter
    alejandra.overlay
    # neovim
    neovim-nightly.overlay
    #unstable overlays
    (_final: prev: {
      unstable = import nixpkgs {
        inherit (prev) system;
        config = {allowUnfree = true;};
      };
    })
  ];
}

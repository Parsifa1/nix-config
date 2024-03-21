{inputs, ...}: {
  overlays = with inputs; [
    #nur overlay
    nur.overlay
    # my nur overlays
    cloudtide.overlay
    # nix formatter
    alejandra.overlay
    # neovim
    (_final: prev: {neovim = inputs.neovim-nightly.packages."${prev.system}".neovim;})
    #unstable overlays
    (_final: prev: {
      unstable = import nixpkgs {
        inherit (prev) system;
        config = {allowUnfree = true;};
      };
    })
  ];
}

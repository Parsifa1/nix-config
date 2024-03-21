{inputs, ...}: {
  overlays = with inputs; [
    #nur overlay
    nur.overlay
    # my nur overlays
    cloudtide.overlay
    # nix formatter
    alejandra.overlay
    #unstable overlays
    (_final: prev: {
      unstable = import nixpkgs-unstable {
        inherit (prev) system;
        config = {allowUnfree = true;};
      };
    })
  ];
}

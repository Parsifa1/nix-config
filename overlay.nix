{inputs, ...}: {
  overlays = with inputs; [
    #nur overlay
    nur.overlay
    #unstable overlays
    (_final: prev: {
      unstable = import nixpkgs-unstable {
        inherit (prev) system;
        config = {allowUnfree = true;};
      };
    })
    # my nur overlays
    (_final: prev: {cloudtide = inputs.cloudtide.packages."${prev.system}";})
    # nix formatter
    alejandra.overlay
  ];
}

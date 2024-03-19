{
  inputs.vsc.url = "github:nix-community/nix-vscode-extensions";
  description = "My personal NUR repository";
  outputs = {
    self,
    nixpkgs,
    vsc
  }: let
    systems = [
      "x86_64-linux"
      "i686-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "armv6l-linux"
      "armv7l-linux"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    legacyPackages = forAllSystems (system:
      import ./default.nix {
        pkgs = nixpkgs.legacyPackages.${system}.appendOverlays[vsc.overlays.default];
      });
    packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});
  };
}

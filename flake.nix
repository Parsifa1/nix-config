{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cloudtide = {
      url = "github:parsifa1/nixpkg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ghostty = {
    #   url = "git+ssh://git@github.com/ghostty-org/ghostty";
    #   inputs.nixpkgs-stable.follows = "nixpkgs";
    #   inputs.nixpkgs-unstable.follows = "nixpkgs";
    # };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: import ./outputs.nix { inherit inputs; };
}

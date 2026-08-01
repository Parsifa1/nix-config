{ pkgs, inputs, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    settings = inputs.self.modules.nixCommon;
  };

  imports = [
    ./home.nix
    ./shell.nix
  ];
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
  ];

  home.sessionVariables = {
    CARGO_HOME = "$HOME/.local/share/cargo";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
  };
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-docs"
      "rust-std"
      "rustc"
      "rust-src"
      "rustfmt"
    ])
    rust-analyzer-nightly
    cargo-xwin
  ];
}

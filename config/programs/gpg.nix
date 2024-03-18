{...}: {
  programs.gpg.settings = {
    keyid-format = "0xlong";
    with-fingerprint = true;
  };
}
